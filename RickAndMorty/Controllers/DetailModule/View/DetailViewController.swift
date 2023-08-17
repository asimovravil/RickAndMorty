//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.reuseID)
        tableView.backgroundColor = AppColor.blackBG.uiColor
        tableView.rowHeight = 102
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var characterDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.rick.uiImage
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var characterDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick Sanchez"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var characterDetailSubtitleLabel: UILabel = {
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
    
    private lazy var descriptionSpeciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Human"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var descriptionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var descriptionGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "Male"
        label.textColor = AppColor.grayNormalBG.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var originTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Origin"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var originCardView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.grayBG.uiColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var planetCardView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.blackElementBG.uiColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.planet.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.text = "Earth"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var originSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Planet"
        label.textColor = AppColor.primaryBG.uiColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private lazy var episodesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episodes"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [characterDetailImageView, characterDetailLabel, characterDetailSubtitleLabel, infoTitleLabel, infoCardView, infoSpeciesLabel, infoTypeLabel, infoGenderLabel, descriptionSpeciesLabel, descriptionTypeLabel, descriptionGenderLabel, originTitleLabel, originCardView, planetCardView, planetImageView, originLabel, originSubtitleLabel, episodesTitleLabel, tableView].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackBG.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        characterDetailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108)
            make.leading.equalToSuperview().offset(113)
            make.trailing.equalToSuperview().offset(-113)
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
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
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
        originTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCardView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        originCardView.snp.makeConstraints { make in
            make.top.equalTo(originTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(80)
        }
        planetCardView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.top.equalTo(originCardView.snp.top).offset(8)
            make.leading.equalTo(originCardView.snp.leading).offset(8)
            make.bottom.equalTo(originCardView.snp.bottom).offset(-8)
        }
        planetImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerX.equalTo(planetCardView.snp.centerX)
            make.centerY.equalTo(planetCardView.snp.centerY)
        }

        originLabel.snp.makeConstraints { make in
            make.top.equalTo(originCardView.snp.top).offset(16)
            make.leading.equalTo(planetCardView.snp.trailing).offset(16)
        }
        originSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(originCardView.snp.top).offset(46)
            make.leading.equalTo(planetCardView.snp.trailing).offset(16)
        }
        episodesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(originCardView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(episodesTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EpisodesTableViewCell.reuseID,
            for: indexPath
        ) as? EpisodesTableViewCell else {
            fatalError("Could not cast to LocalizationViewCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = AppColor.blackBG.uiColor
        return cell
    }
}
