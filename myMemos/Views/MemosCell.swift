//
//  TableViewCell.swift
//  myMemos
//
//  Created by Александра Кострова on 07.05.2023.
//

import UIKit

class MemosCell: UITableViewCell {
    
    static let identifier = Keys.memosCellIdentifier

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
