// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import SwiftUI

public struct Route: Hashable, Identifiable {
    public let id = UUID()
    public let path: String
    public let param: [String: AnyHashable?]?
    
    public init(path: String, param: [String : AnyHashable?]?) {
        self.path = path
        self.param = param
    }
    
    public init(path: String) {
        self.path = path
        self.param = nil
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(path)
        param?.forEach { key, value in
            hasher.combine(key)
            hasher.combine(value)
        }
    }

    public static func ==(lhs: Route, rhs: Route) -> Bool {
        return lhs.id == rhs.id &&
               lhs.path == rhs.path &&
               lhs.param == rhs.param
    }
}

public class Router: ObservableObject{
    @Published fileprivate var path: [Route] = []
    @Published fileprivate var rootView: Route? = nil
    private var completions: [(id: UUID, completion: Any?)] = []
    
    fileprivate init() {}
    
    fileprivate func initialize(_ root: Route)  {
        let rootView = root
        self.rootView = rootView
        self.path = [rootView]
    }
    
    public func push(_ id: UUID, _ path: String, param: [String: AnyHashable?]? = nil) {
        sync(id: id)
        self.path.append(Route(path: path, param: param))
    }
    
    public func push(
        _ id: UUID,
        _ path: String,
        param: [String: AnyHashable?]? = nil,
        completion: @escaping (Any) -> Void
    ) {
        sync(id: id)
        let route = Route(path: path, param: param)
        self.path.append(route)
        self.completions.append((id: id, completion: completion))
    }

    
    private func sync(id: UUID){
        if let currentId = path.last?.id{
            if id != currentId {
                #if DEBUG
                print("Sync Route")
                #endif
                removeUntil(array: &path) { $0.id == id }
            }
        }
    }
    
    private func removeUntil(array: inout [Route], condition: (Route) -> Bool) {
        while !array.isEmpty && !condition(array.last!) {
            array.removeLast()
        }
    }
        
    public func pop(result: Any? = nil) {
        guard !path.isEmpty else { return }
        
        path.removeLast()
        guard let last = path.last else { return }
        
        if let result = result {
            complete(withID: last.id, result: result)
        } else {
            if let index = completions.firstIndex(where: { $0.id == last.id }) {
                completions.remove(at: index)
            }
        }
    }
    
    public func pushReplace(_ path: String) {
        let route = Route(path: path)
        if self.path.count == 1 {
            self.rootView = route
        }
        self.path.append(route)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.path.remove(at: self.path.endIndex - 2 )
        }
    }
    
//    func popToRoot() {
//        self.path.removeLast(self.path.count - 1)
//    }
    
    private func complete(withID id: UUID, result: Any) {
        if let index = completions.firstIndex(where: { $0.id == id }) {
            if let completion = completions[index].completion as? (Any) -> Void {
                completion(result)
                completions.remove(at: index)
            }
        }
    }
    
    @ViewBuilder
    fileprivate func build(_ view: some View,_ route: Route) -> some View {
        view
            .navigationBarBackButtonHidden(rootView?.id == route.id)
    }
    
}

public struct NavigationRouter<Content: View>: View {
    @StateObject private var router = Router()
    
    var destination: (Route) -> Content
    var rootPath: Route
    
    public init(rootPath: Route, @ViewBuilder destination: @escaping (Route) -> Content) {
        self.destination = destination
        self.rootPath = rootPath
    }
    
    public var body: some View {
        Group {
            NavigationStack(path: $router.path){
                EmptyView()
                .navigationDestination(for: Route.self ){ route in
                    router.build(destination(route), route)
                }
            }
            .onAppear {
                self.router.initialize(rootPath)
            }
            .onReceive(self.router.$path) { v in
                let routePath = v.map { $0.path}
                #if DEBUG
                print("On Change Route: \(routePath)")
                #endif
            }
        }
        .environmentObject(router)
    }
}
