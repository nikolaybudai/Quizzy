//
//  CategoryCell.swift
//  Quizzy
//
//  Created by Nikolay Budai on 31/10/23.
//

import UIKit

final class CategoryCell: UITableViewCell {
    
    static let identifier = "CategoryCell"
    
    private let nameLabel = UILabel()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupNameLabel()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
    }
    
    //MARK: Methods
    func setupCell(viewModel: CategoryCellViewModelProtocol) {
        nameLabel.text = viewModel.name
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .customBackground
        contentView.layer.cornerRadius = 15
        
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 3, height: 4)
        contentView.layer.shadowRadius = 2
    }
    
    private func setupNameLabel() {
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 26)
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
    }
}

extension CategoryCell {
    private func addConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
}
