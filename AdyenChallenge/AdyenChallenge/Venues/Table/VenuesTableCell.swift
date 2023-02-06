//
//  VenuesTableCell.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import UIKit


class VenuesTableCell: UITableViewCell {
    
    private lazy var contentStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            distanceLabel,
            tagsLabel
       ])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: ViewConstants.nameFontSize, weight: .semibold)
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: ViewConstants.distanceFontSize, weight: .semibold)
        return label
    }()
    
    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: ViewConstants.tagsFontSize, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constructView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructView() {
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstants.insets.top),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewConstants.insets.bottom),
            contentStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ViewConstants.insets.left),
            contentStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: ViewConstants.insets.right)
            
        ])
    }
    
    func configure(viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        distanceLabel.text = String(viewModel.distance) + ViewConstants.distanceText
        let tags = viewModel.tags.joined(separator: ", ")
        tagsLabel.text = tags.isEmpty ? "" : ViewConstants.tagsText + tags
    }
    
}

extension VenuesTableCell {

    public typealias ViewModel = Venue

    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    struct ViewConstants {
        
        static let insets: UIEdgeInsets = .init(top: 12,
                                                left: 12,
                                                bottom: -12,
                                                right: -12)
        static let distanceText = " meters away"
        static let tagsText = "Tags: "
        static let nameFontSize: CGFloat = 20
        static let distanceFontSize: CGFloat = 12
        static let tagsFontSize: CGFloat = 12

    }
}
