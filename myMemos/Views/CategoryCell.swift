//
//  CategoryCell.swift
//  myMemos
//
//  Created by Александра Кострова on 15.05.2023.
//

import UIKit

class CategoryCell: UITableViewCell {

    static let identifier = Keys.categoryСellIdentifier

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        contentView.backgroundColor = .white
    }
}
