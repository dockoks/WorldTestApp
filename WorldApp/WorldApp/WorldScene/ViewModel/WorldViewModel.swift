import Foundation

protocol WorldViewModelProtocol {
    var cellsUpdated: (() -> Void)? { get set }
    var numberOfCells: Int { get }
    var lifeDiedCellIndex: Int? { get }
    func cellState(at index: Int) -> CellState
    func addNewCell()
}

class WorldViewModel: WorldViewModelProtocol {
    private let cellManager: CellManagerProtocol
    var cellsUpdated: (() -> Void)?
    var lifeDiedCellIndex: Int?

    init(cellManager: CellManagerProtocol = CellManager()) {
        self.cellManager = cellManager
    }
    
    var numberOfCells: Int {
        return cellManager.cells.count
    }
    
    func cellState(at index: Int) -> CellState {
        return cellManager.cells[index]
    }
    
    func addNewCell() {
        lifeDiedCellIndex = cellManager.addNewCell()
        cellsUpdated?()
    }
}
