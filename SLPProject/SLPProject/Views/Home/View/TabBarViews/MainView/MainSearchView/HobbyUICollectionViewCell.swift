//
//  HobbyUICollectionViewCell.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/08.
//

import UIKit
import SnapKit

enum HobbyColor {
    case red
    case black
    case green
}

class HobbyUICollectionViewCell: UICollectionViewCell, FetchViews {
    
    static let identifier = "HobbyUICollectionViewCell"
    
    var state: HobbyColor = .black {
        didSet {
            switch state {
            case .red:
                self.layer.borderColor = UIColor.slpError.cgColor
                hobbyLabel.textColor = .red
                deleteButton.tintColor = .red
                deleteButton.isHidden = true
            case .black:
                self.layer.borderColor = UIColor.slpBlack.cgColor
                hobbyLabel.textColor = .slpBlack
                deleteButton.tintColor = .slpBlack
                deleteButton.isHidden = true
            case .green:
                self.layer.borderColor = UIColor.slpGreen.cgColor
                hobbyLabel.textColor = .slpGreen
                deleteButton.tintColor = .slpGreen
            }
        }
    }
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textAlignment = .center
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(stackView)
        
        [hobbyLabel, deleteButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        
        self.snp.makeConstraints {
            $0.height.equalTo(32)
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        deleteButton.snp.makeConstraints {
            $0.width.height.equalTo(10)
        }
    }
    
}
