// WorldViewController.swift
import UIKit

final class WorldViewController: UIViewController {
    private var viewModel: WorldViewModelProtocol
    
    private let gradient = CAGradientLayer()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.viewTitle
        label.textColor = ColorPalette.Text.onPrimary
        label.font = WorldFont.Styles.header
        label.textAlignment = .center
        return label
    }()
    private let tableView = UITableView()
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorPalette.Main.primaryColor
        button.setTitle(Constants.addButtonTitle.uppercased(), for: .normal)
        button.setTitleColor(ColorPalette.Text.onPrimary, for: .normal)
        button.titleLabel?.font = WorldFont.Styles.button
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    init(viewModel: WorldViewModelProtocol = WorldViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = view.bounds
    }
    
    private func setupUI() {
        gradient.colors = [ColorPalette.Background.layerOneTop.cgColor, ColorPalette.Background.layerOneBottom.cgColor]
        view.backgroundColor = .clear
        view.layer.insertSublayer(gradient, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: Constants.contentBottomOffset, right: 0)
        tableView.backgroundColor = .clear
        tableView.register(WorldTableViewCell.self, forCellReuseIdentifier: WorldTableViewCell.reuseIdentifier)
        
        addButton.addTarget(self, action: #selector(addCellButtonTapped), for: .touchUpInside)
        
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: Constants.headerLabelHeight),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonPadding),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonPadding),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.buttonPadding),
            addButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupBindings() {
        viewModel.cellsUpdated = { [weak self] in
            guard let self = self else { return }
            
            let newCellsCount = self.viewModel.numberOfCells
            let oldCellsCount = self.tableView.numberOfRows(inSection: 0)
            
            if newCellsCount > oldCellsCount {
                let newIndexPaths = (oldCellsCount..<newCellsCount).map { IndexPath(row: $0, section: 0) }
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: newIndexPaths, with: .automatic)
                self.tableView.endUpdates()
                
                if let lastNewIndexPath = newIndexPaths.last {
                    self.tableView.scrollToRow(at: lastNewIndexPath, at: .bottom, animated: true)
                }
            }
            
            if let lifeDiedIndex = self.viewModel.lifeDiedCellIndex {
                let lifeDiedIndexPath = IndexPath(row: lifeDiedIndex, section: 0)
                self.tableView.reloadRows(at: [lifeDiedIndexPath], with: .automatic)
            }
        }
    }
    
    @objc private func addCellButtonTapped() {
        viewModel.addNewCell()
    }
}

// MARK: - Constants
private extension WorldViewController {
    enum Constants {
        static let viewTitle = "Клеточное наполнение"
        static let addButtonTitle = "Сотворить"

        static let headerLabelHeight: CGFloat = 56
        static let buttonHeight: CGFloat = 36.0
        static let buttonCornerRadius: CGFloat = 4.0
        static let buttonPadding: CGFloat = 16.0
        static let contentBottomOffset: CGFloat = 120
        static let spacing: CGFloat = 10.0
    }
}

// MARK: - UITableViewDataSource
extension WorldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WorldTableViewCell.reuseIdentifier, for: indexPath) as? WorldTableViewCell {
            let cellState = viewModel.cellState(at: indexPath.row)
            cell.configure(with: cellState)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension WorldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
