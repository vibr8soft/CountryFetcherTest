class DependenciesContainer {
    static let shared = DependenciesContainer()

    private init() {}

    private var dependencies: [String: Any] = [:]

    func register<Dependency>(type: Dependency.Type, factory: @autoclosure @escaping () -> Dependency) {
        let key = String(describing: type.self)
        dependencies[key] = factory()
    }

    func resolve<Dependency>() -> Dependency {
        let key = String(describing: Dependency.self)
        guard let service = dependencies[key] as? Dependency else {
            fatalError("Unable to resolve \(key)")
        }
        return service
    }
}
