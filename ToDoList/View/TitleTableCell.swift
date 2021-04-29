//
//  TitleTableCell.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit

internal final class TitleTableCell: UITableViewCell {
    typealias DeleteAction = ( (_ index: Int) -> Void)
    internal lazy var titleLabel = makeTitleLabel()
    internal lazy var deleteButton = makeDeleteButton()
    internal var deleteButtonAction: DeleteAction?
    private var indexPath = IndexPath.init()
    
    override internal init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layoutViews()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    internal func configure(title: String, indexPath: IndexPath) {
        titleLabel.text = title
        self.indexPath = indexPath
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension TitleTableCell {
    func layoutViews() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIDimension.Spacing.medium),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIDimension.Spacing.medium),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIDimension.Spacing.medium),
            deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIDimension.Spacing.medium),
            deleteButton.heightAnchor.constraint(equalToConstant: UIDimension.IconHeight.small),
            deleteButton.widthAnchor.constraint(equalToConstant: UIDimension.IconWidth.small),
            deleteButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: UIDimension.Spacing.medium)
        ])
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
    func makeDeleteButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("X", for: .normal)
        return button
    }
    
    @objc
    func deleteButtonTapped() {
        deleteButtonAction?(indexPath.row)
    }
}
