//
//  EpisodesTableViewCell.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class CharactersTableViewCell: UITableViewCell {

    static let reuseID = String(describing: CharactersTableViewCell.self)
    
    // MARK: - UI
    
    public lazy var characterDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    public lazy var characterDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick Sanchez"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    public lazy var characterDetailSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Alive"
        label.textColor = AppColor.primaryBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var infoCardView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.grayBG.uiColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var infoSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var infoTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type:"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var infoGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    public lazy var descriptionSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Human"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    public lazy var descriptionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    public lazy var descriptionGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "Male"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setupViews

    private func setupViews() {
        [characterDetailImageView, characterDetailLabel, characterDetailSubtitleLabel, infoTitleLabel, infoCardView, infoSpeciesLabel, infoTypeLabel, infoGenderLabel, descriptionSpeciesLabel, descriptionTypeLabel, descriptionGenderLabel].forEach {
            contentView.addSubview($0)
        }
    }

    // MARK: - setupConstraints

    private func setupConstraints() {
        characterDetailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(113)
            make.trailing.equalToSuperview().offset(-113)
            make.height.equalTo(148)
        }
        characterDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(characterDetailImageView.snp.bottom).offset(24)
            make.centerX.equalTo(characterDetailImageView.snp.centerX)
        }
        characterDetailSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterDetailLabel.snp.bottom).offset(8)
            make.centerX.equalTo(characterDetailImageView.snp.centerX)
        }
        infoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterDetailSubtitleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        infoCardView.snp.makeConstraints { make in
            make.top.equalTo(infoTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(124)
        }
        infoSpeciesLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.top).offset(16)
            make.leading.equalTo(infoCardView.snp.leading).offset(16)
        }
        infoTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.top).offset(52)
            make.leading.equalTo(infoCardView.snp.leading).offset(16)
        }
        infoGenderLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.top).offset(88)
            make.leading.equalTo(infoCardView.snp.leading).offset(16)
        }
        descriptionSpeciesLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.top).offset(16)
            make.trailing.equalTo(infoCardView.snp.trailing).offset(-16)
        }
        descriptionTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.top).offset(52)
            make.trailing.equalTo(infoCardView.snp.trailing).offset(-16)
        }
        descriptionGenderLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.top).offset(88)
            make.trailing.equalTo(infoCardView.snp.trailing).offset(-16)
        }
    }
    
    // MARK: - Actions
    
    public func configureCharacter(with character: Character) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: character.image),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.characterDetailImageView.image = image
                    self.characterDetailLabel.text = character.name
                    self.characterDetailSubtitleLabel.text = character.status
                    self.descriptionSpeciesLabel.text = character.species
                    if !character.type.isEmpty {
                        self.descriptionTypeLabel.text = character.type
                    } else {
                        self.descriptionTypeLabel.text = "None"
                    }
                    self.descriptionGenderLabel.text = character.gender
                }
            }
        }
    }
}
