import ComposableArchitecture
import SwiftUI

/// Helpers to send LocalAction
public extension ViewStore {
    /// Sends a local action wrapped in a `ComposedAction`.
    ///
    /// - Parameter localAction: The local action to send.
    /// - Returns: The task of the view store.
    @discardableResult
    func send<LocalAction, ParentAction>(
        _ localAction: LocalAction
    ) -> ViewStoreTask where ViewAction == ComposedAction<LocalAction, ParentAction> {
        send(.local(localAction))
    }

    /// Sends a local action wrapped in a `ComposedAction` with an animation.
    ///
    /// - Parameters:
    ///   - localAction: The local action to send.
    ///   - animation: The animation to apply.
    /// - Returns: The task of the view store.
    @discardableResult
    func send<LocalAction, ParentAction>(
        _ localAction: LocalAction,
        animation: Animation?
    ) -> ViewStoreTask where ViewAction == ComposedAction<LocalAction, ParentAction> {
        send(.local(localAction), animation: animation)
    }

    /// Sends a local action wrapped in a `ComposedAction` with a transaction.
    ///
    /// - Parameters:
    ///   - localAction: The local action to send.
    ///   - transaction: The transaction to apply.
    /// - Returns: The task of the view store.
    @discardableResult
    func send<LocalAction, ParentAction>(
        _ localAction: LocalAction,
        transaction: Transaction
    ) -> ViewStoreTask where ViewAction == ComposedAction<LocalAction, ParentAction> {
        send(.local(localAction), transaction: transaction)
    }

    /// Creates a binding from a state value to a local action.
    ///
    /// - Parameters:
    ///   - get: A closure that gets a value from the state.
    ///   - valueToLocalAction: A closure that transforms the value to a local action.
    /// - Returns: A binding from the state value to the local action.
    func binding<Value, LocalAction, ParentAction>(
        get: @escaping (ViewState) -> Value,
        send valueToLocalAction: @escaping (Value) -> LocalAction
    ) -> Binding<Value> where ViewAction == ComposedAction<LocalAction, ParentAction> {
        self.binding(get: get, send: { .local(valueToLocalAction($0)) })
    }

    /// Creates a binding from a state value to a local action.
    ///
    /// - Parameters:
    ///   - get: A closure that gets a value from the state.
    ///   - localAction: The local action to bind to the state value.
    /// - Returns: A binding from the state value to the local action.
    func binding<Value, LocalAction, ParentAction>(
        get: @escaping (ViewState) -> Value,
        send localAction: LocalAction
    ) -> Binding<Value> where ViewAction == ComposedAction<LocalAction, ParentAction> {
        self.binding(get: get, send: .local(localAction))
    }
}
