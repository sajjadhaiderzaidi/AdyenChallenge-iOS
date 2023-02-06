//
//  ViewController.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 04/02/2023.
//

import UIKit

protocol PermissionViewProtocol {
    
    func render(viewModel: PermissionViewModel)
    func setLoadingState(isLoading: Bool)
    
}

typealias PermissionViewControllerProtocol = PermissionViewProtocol & UIViewController

final class PermissionViewController: PermissionViewControllerProtocol {

    private var presenter: PermissionPresenterProtocol
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            label,
            button
        ])
        stack.spacing = ViewMatrics.stackSpacing
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var button = UIButton(configuration: .filled())
    
    init(presenter: PermissionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructView()
        presenter.loadData()
    }
    
    private func constructView() {
        view.addSubview(contentStack)
        view.addSubview(spinner)
        setupConstraints()
        setContentVisibility(hidden: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor),
            contentStack.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setContentVisibility(hidden: Bool) {
        contentStack.isHidden = hidden
        spinner.isHidden = !hidden
    }
}

extension PermissionViewController {
    
    func setLoadingState(isLoading: Bool) {
        setContentVisibility(hidden: isLoading)
        isLoading ? spinner.startAnimating() : spinner.stopAnimating()
    }
    
    func render(viewModel: PermissionViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.ctaText, for: .normal)
        button.addAction(command: viewModel.ctaAction)
    }
    
}

extension PermissionViewController {
    
    struct ViewMatrics {

        static let stackSpacing: CGFloat = 24

        private init() {}

    }
    
}
