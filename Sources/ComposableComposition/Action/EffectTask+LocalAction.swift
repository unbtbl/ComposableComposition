import ComposableArchitecture

// This is really an extension to EffectTask, which is a typealias to EffectPublisher
public extension EffectPublisher where Failure == Never {
    /// Transforms the actions of the task using the provided transform function.
    /// The transformed actions are wrapped in a `ComposedAction` as local actions.
    ///
    /// - Parameter transform: A function that transforms the actions of the publisher into local actions.
    /// - Returns: An `EffectPublisher` that publishes composed actions with the transformed local actions.
    func map<LocalAction, ParentAction>(_ transform: @escaping (Action) -> LocalAction) -> EffectPublisher<ComposedAction<LocalAction, ParentAction>, Failure> {
        return self.map { (action: Action) -> ComposedAction<LocalAction, ParentAction> in
            let local = transform(action)
            return ComposedAction<LocalAction, ParentAction>.local(local)
        }
    }

    /// Creates an `EffectPublisher` that sends a local action wrapped in a `ComposedAction`.
    ///
    /// - Parameter localAction: The local action to send.
    /// - Returns: An `EffectPublisher` that sends the composed action.
    static func send<Local, Parent>(_ localAction: Local) -> Self where Action == ComposedAction<Local, Parent> {
        Self.send(ComposedAction.local(localAction))
    }
}

