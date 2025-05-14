//
//  CoffeeServiceTests.swift
//  DemoAppForTests
//
//  Created by Aleksey Lesnikov on 14.05.2025.
//

import XCTest
@testable import DemoAppForTests

final class CoffeeServiceTests: XCTestCase {

    var coffeeService: CoffeeService!

    override func setUp() {
        super.setUp()
        coffeeService = CoffeeService()
    }

    override func tearDown() {
        coffeeService = nil
        super.tearDown()
    }

    
    func testFetchCoffeesReturnsList() async throws {
        let coffees = try await coffeeService.fetchCoffees()
        XCTAssertFalse(coffees.isEmpty, "Coffee list should not be empty")
    }

    
    func testPlaceOrderCreatesNewOrder() async throws {
        let coffees = try await coffeeService.fetchCoffees()
        let selected = coffees.first!
        let customer = "Test User"

        let order = try await coffeeService.placeOrder(
            coffeeId: selected.id,
            quantity: 2,
            customerName: customer
        )

        XCTAssertEqual(order.coffeeId, selected.id)
        XCTAssertEqual(order.quantity, 2)
        XCTAssertEqual(order.customerName, customer)
        XCTAssertEqual(order.status, .pending)
    }

    
    func testGetOrderStatusReturnsCorrectOrder() async throws {
        let coffees = try await coffeeService.fetchCoffees()
        let coffee = coffees[0]

        let placed = try await coffeeService.placeOrder(
            coffeeId: coffee.id,
            quantity: 1,
            customerName: "John"
        )

        let fetched = try await coffeeService.getOrderStatus(orderId: placed.id)

        XCTAssertEqual(fetched.id, placed.id)
        XCTAssertEqual(fetched.status, .pending)
    }

    
    func testGetOrderStatusThrowsForInvalidId() async {
        do {
            _ = try await coffeeService.getOrderStatus(orderId: -1)
            XCTFail("Expected error for invalid order ID")
        } catch CoffeeError.invalidOrderId {
            // success
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    
    func testCancelOrderChangesStatus() async throws {
        let coffee = try await coffeeService.fetchCoffees()[0]
        let order = try await coffeeService.placeOrder(coffeeId: coffee.id, quantity: 1, customerName: "CancelMe")

        let success = try await coffeeService.cancelOrder(orderId: order.id)
        XCTAssertTrue(success)

        let cancelled = try await coffeeService.getOrderStatus(orderId: order.id)
        XCTAssertEqual(cancelled.status, .cancelled)
    }

    
    func testCancelOrderTwiceThrowsError() async throws {
        let coffee = try await coffeeService.fetchCoffees()[0]
        let order = try await coffeeService.placeOrder(coffeeId: coffee.id, quantity: 1, customerName: "Twice")

        _ = try await coffeeService.cancelOrder(orderId: order.id)

        do {
            _ = try await coffeeService.cancelOrder(orderId: order.id)
            XCTFail("Expected error for already cancelled order")
        } catch CoffeeError.orderAlreadyCancelled {
            // success
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
