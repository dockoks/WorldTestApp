import Foundation

protocol CellManagerProtocol {
    var cells: [CellState] { get }
    func addNewCell() -> Int?
}

// CellManager.swift
final class CellManager: CellManagerProtocol {
    private(set) var cells: [CellState] = []
    
    private var aliveCount = 0
    private var deadCount = 0
    private var lastLifeBornIndex: Int?
    
    // Add a new cell and apply business rules
    func addNewCell() -> Int? {
        let newCell = generateRandomCell()
        cells.append(newCell)
        
        // Update consecutive counters
        if newCell == .alive {
            aliveCount += 1
            deadCount = 0
        } else {
            deadCount += 1
            aliveCount = 0
        }
        
        // Apply life or death rules
        if aliveCount == 3 {
            return createLifeBorn()
        } else if deadCount == 3 {
            return killNearbyLifeBorn()
        }
        
        return nil
    }
    
    // Generate a random cell, either alive or dead
    private func generateRandomCell() -> CellState {
        return Bool.random() ? .alive : .dead
    }
    
    // Append a "Life was born" cell and return its index
    private func createLifeBorn() -> Int? {
        let newLifeBornCellIndex = cells.count
        cells.append(.lifeBorn)
        lastLifeBornIndex = newLifeBornCellIndex
        return nil
    }
    
    // Change the most recent "Life was born" cell to "Life died" and return its index
    private func killNearbyLifeBorn() -> Int? {
        if let index = lastLifeBornIndex, cells[index] == .lifeBorn {
            cells[index] = .lifeDied
            lastLifeBornIndex = nil
            return index
        }
        return nil
    }
}
