import ComposableArchitecture

/// A protocol for a reducer that can handle actions that are local to a specific component or pass others to a parent component for handling.
/// This protocol is useful in conjunction with `ComposedState`.
public protocol ComposedActionReducer: ReducerProtocol where Action == ComposedAction<LocalAction, ParentAction> {
    associatedtype LocalAction
    associatedtype ParentAction

    /// A method to handle actions and produce an effect task.
    ///
    /// - Parameters:
    ///   - state: A reference to the current state that can be modified.
    ///   - action: The action to handle.
    /// - Returns: An effect task that encapsulates work to be done in response to the action.
    func reduce(into state: inout State, action: LocalAction) -> EffectTask<Action>
}

public extension ComposedActionReducer {
    /// A function to compose multiple reducers together. Used in the body of a reducer, for example, `Reducer(core)`.
    ///
    /// - Parameters:
    ///   - state: A reference to the current state that can be modified.
    ///   - action: The action to handle.
    /// - Returns: An effect task that encapsulates work to be done in response to the action.
    func core(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .local(let local):
            return self.reduce(into: &state, action: local)
        case .parent:
            return .none
        }
    }
}

/// A default implementation of `reduce(into:action:)` for reducers that don't have a `body`.
public extension ComposedActionReducer where Body == Never {
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        core(into: &state, action: action)
    }
}
