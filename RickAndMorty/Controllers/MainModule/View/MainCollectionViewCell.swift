//
//  MainCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    var characterButtonTappedHandler: (() -> Void)?
    static let reuseID = String(describing: MainCollectionViewCell.self)
    
    // MARK: - UI
    
    private lazy var characterView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.grayBG.uiColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.rick.uiImage
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var characterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rick Sanchez", for: .normal)
        button.setTitleColor(AppColor.whiteBG.uiColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(characterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [characterView, characterImageView, characterButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        characterView.snp.makeConstraints { make in
            make.width.equalTo(156)
            make.height.equalTo(202)
        }
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(characterView.snp.top).offset(8)
            make.leading.equalTo(characterView.snp.leading).offset(8)
            make.trailing.equalTo(characterView.snp.trailing).offset(-8)
            make.bottom.equalTo(characterView.snp.bottom).offset(-54)
        }
        characterButton.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(16)
            make.centerX.equalTo(characterView.snp.centerX)
        }
    }
    
    // MARK: - Actions
    
    @objc private func characterButtonTapped(_ sender: UIButton) {
        characterButtonTappedHandler?()
    }
    
    func configure(with character: Character) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: character.image) {
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: data)
                }
            }
        }
        characterButton.setTitle(character.name, for: .normal)
    }
    
}
