//
//  ComposedStateTests.swift
//  
//
//  Created by Robbert Brandsma on 03/07/2023.
//

import XCTest
import ComposableComposition

final class ComposedStateTests: XCTestCase {

    // Test structs for the purpose of testing
    struct ChildStruct: Equatable, Hashable {
        var childValue: Int
    }
    
    struct ParentStruct: Equatable, Hashable {
        var parentValue: Int
    }
    
    func testChildAccess() {
        let child = ChildStruct(childValue: 10)
        let parent = ParentStruct(parentValue: 20)
        var composedState = ComposedState(child: child, parent: parent)
        
        XCTAssertEqual(composedState.child, child, "Child state does not match the expected value.")
        XCTAssertEqual(composedState.childValue, 10, "Child state dynamic member does not match the expected value.")
        
        composedState.childValue = 15
        XCTAssertEqual(composedState.childValue, 15, "Child state dynamic member does not match the updated value.")
    }
    
    func testParentAccess() {
        let child = ChildStruct(childValue: 10)
        let parent = ParentStruct(parentValue: 20)
        let composedState = ComposedState(child: child, parent: parent)
        
        XCTAssertEqual(composedState.parent, parent, "Parent state does not match the expected value.")
        XCTAssertEqual(composedState.parentValue, 20, "Parent state dynamic member does not match the expected value.")
    }
    
    func testEquatable() {
        let child = ChildStruct(childValue: 10)
        let parent = ParentStruct(parentValue: 20)
        let composedState1 = ComposedState(child: child, parent: parent)
        let composedState2 = ComposedState(child: child, parent: parent)
        
        XCTAssertEqual(composedState1, composedState2, "ComposedState instances with equal child and parent states are not considered equal.")
    }
    
    func testHashable() {
        let child = ChildStruct(childValue: 10)
        let parent = ParentStruct(parentValue: 20)
        let composedState1 = ComposedState(child: child, parent: parent)
        let composedState2 = ComposedState(child: child, parent: parent)
        
        XCTAssertEqual(composedState1.hashValue, composedState2.hashValue, "ComposedState instances with equal child and parent states do not have equal hash values.")
    }
}
