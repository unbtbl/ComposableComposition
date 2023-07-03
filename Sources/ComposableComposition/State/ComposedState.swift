/// A `ComposedState` is a type that composes the state of two other types, allowing access to the properties of both.
/// It allows read-only access to the parent state and read-write access to the child state.
@dynamicMemberLookup
public struct ComposedState<Child, Parent> {
    /// The state that can be read from and written to.
    public var child: Child

    /// The state that can only be read from.
    public let parent: Parent

    /// Accesses the value of the parent state using the given key path.
    public subscript<T>(dynamicMember keyPath: KeyPath<Parent, T>) -> T {
        parent[keyPath: keyPath]
    }

    /// Accesses the value of the child state using the given key path.
    public subscript<T>(dynamicMember keyPath: KeyPath<Child, T>) -> T {
        child[keyPath: keyPath]
    }

    /// Accesses and modifies the value of the child state using the given key path.
    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Child, T>) -> T {
        get { child[keyPath: keyPath] }
        set { child[keyPath: keyPath] = newValue }
    }

    /// Initializes a new instance of `ComposedState` with the given child and parent states.
    ///
    /// - Parameters:
    ///   - child: The child state that can be read from and written to.
    ///   - parent: The parent state that can only be read from.
    public init(child: Child, parent: Parent) {
        self.child = child
        self.parent = parent
    }
}

extension ComposedState: Equatable where Child: Equatable, Parent: Equatable {}
extension ComposedState: Hashable where Child: Hashable, Parent: Hashable {}
