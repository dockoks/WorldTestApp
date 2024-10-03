import Foundation

protocol CellManagerProtocol {
    var cells: [CellState] { get }
    func addNewCell() -> Int?
}

final class CellManager: CellManagerProtocol {
    private(set) var cells: [CellState] = []
    
    private var aliveCount = 0
    private var deadCount = 0
    private var lastLifeBornIndex: Int?
    
    func addNewCell() -> Int? {
        let newCell = generateRandomCell()
        cells.append(newCell)
        
        if newCell == .alive {
            aliveCount += 1
            deadCount = 0
        } else {
            deadCount += 1
            aliveCount = 0
        }
        
        if aliveCount == 3 {
            return createLifeBorn()
        } else if deadCount == 3 {
            return killNearbyLifeBorn()
        }
        
        return nil
    }
    
    private func generateRandomCell() -> CellState {
        return Bool.random() ? .alive : .dead
    }
    
    private func createLifeBorn() -> Int? {
        let newLifeBornCellIndex = cells.count
        cells.append(.lifeBorn)
        lastLifeBornIndex = newLifeBornCellIndex
        return nil
    }
    
    private func killNearbyLifeBorn() -> Int? {
        if let index = lastLifeBornIndex, cells[index] == .lifeBorn {
            cells[index] = .lifeDied
            lastLifeBornIndex = nil
            return index
        }
        return nil
    }
}
