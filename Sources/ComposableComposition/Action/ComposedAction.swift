import ComposableArchitecture

/// An enum representing an action that is either local to a specific reducer or is passed to a parent reducer for handling.
public enum ComposedAction<Local, Parent> {
    /// An action for the local reducer.
    case local(Local)

    /// An action for the parent reducer.
    case parent(Parent)
}

extension ComposedAction: Equatable where Local: Equatable, Parent: Equatable {}
extension ComposedAction: Hashable where Local: Hashable, Parent: Hashable {}
extension ComposedAction: CaseIterable where Local: CaseIterable, Parent: CaseIterable {
    public static var allCases: [Self] {
        Local.allCases.map(Self.local) + Parent.allCases.map(Self.parent)
    }
}
extension ComposedAction: BindableAction where Local: BindableAction {
    public typealias State = Local.State
    public static func binding(_ action: BindingAction<State>) -> ComposedAction<Local, Parent> {
        .local(.binding(action))
    }
}
