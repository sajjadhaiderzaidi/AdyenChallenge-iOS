//
//  VenuesViewController.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import UIKit

protocol VenuesViewProtocol {
    
    func render(viewModel: VenuesViewModel)
    func updateState(state: VenuesViewState)
    
}

/// View state input
public enum VenuesViewState: Equatable {
    
    case showSpinner, showRetry, showData
    
}

typealias VenuesViewControllerProtocol = VenuesViewProtocol & UIViewController


final class VenuesViewController: VenuesViewControllerProtocol {
    
    private var presenter: VenuesPresenterProtocol
    private var dataSource: VenuesTableDataSourceProtocol
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private lazy var spinnerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            spinner,
            loadingLabel,
            button
        ])
        button.isHidden = true
        spinner.startAnimating()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = ViewConstants.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    

    private lazy var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

    private lazy var loadingLabel = UILabel()

    private lazy var button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle(ViewConstants.ctaTitle, for: .normal)
        return button
    }()

    
    init(presenter: VenuesPresenterProtocol,
         dataSource: VenuesTableDataSourceProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = ViewConstants.screenTitle
        constructView()
        presenter.loadData()
    }
    
}

//MARK: - private methods
extension VenuesViewController {
    
    private func constructView() {
        view.addSubview(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.isHidden = true
        dataSource.registerCell(in: tableView)
        view.addSubview(spinnerStack)
        setupConstraints()
        button.addAction(command: Command { [weak self] in
            self?.presenter.loadData()
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            spinnerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setContentVisibility(hidden: Bool) {
        tableView.isHidden = hidden
        spinnerStack.isHidden = !hidden
    }
    
    private func setSpinnerVisibility(hidden: Bool) {
        hidden ? spinner.stopAnimating() : spinner.startAnimating()
        spinner.isHidden = hidden
    }
    
    private func setButtonVisibility(hidden: Bool) {
        button.isHidden = hidden
    }
    
}

//MARK: - VenuesViewProtocol conformance
extension VenuesViewController {
    
    func render(viewModel: VenuesViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadingLabel.text = viewModel.loadingText
            guard self.tableView.numberOfRows(inSection: 0) != viewModel.venues.count else  { return }
            self.dataSource.display(cellsWith: viewModel.venues, in: self.tableView)
        }
    }
    
    func updateState(state: VenuesViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setContentVisibility(hidden: state != .showData)
            self.setSpinnerVisibility(hidden: state != .showSpinner)
            self.setButtonVisibility(hidden: state != .showRetry)
        }
    }
    
}

extension VenuesViewController {
    
    /// View constants
    struct ViewConstants {
        
        static let screenTitle = "Venues Nearby"
        static let ctaTitle = "Retry"
        static let stackSpacing: CGFloat = 24
        
        private init() {}
    
    }
    
}
