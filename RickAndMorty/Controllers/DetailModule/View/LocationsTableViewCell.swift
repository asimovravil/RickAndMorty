//
//  LocationsTableViewCell.swift
//  RickAndMorty
//
//  Created by Ravil on 19.08.2023.
//

import UIKit
import SnapKit

final class LocationsTableViewCell: UITableViewCell {

    static let reuseID = String(describing: LocationsTableViewCell.self)
    
    // MARK: - UI
    
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
    
    public lazy var originLabel: UILabel = {
        let label = UILabel()
        label.text = "Earth"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    public lazy var originSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Planet"
        label.textColor = AppColor.primaryBG.uiColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    public lazy var episodesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episodes"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
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
        [originTitleLabel, originCardView, planetCardView, planetImageView, originLabel, originSubtitleLabel, episodesTitleLabel].forEach {
            contentView.addSubview($0)
        }
    }

    // MARK: - setupConstraints

    private func setupConstraints() {
        originTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(24)
        }
        originCardView.snp.makeConstraints { make in
            make.top.equalTo(originTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
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
            make.top.equalTo(originCardView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    // MARK: - Actions

    public func configureLocation(with location: Location) {
        originLabel.text = location.name
        originSubtitleLabel.text = location.type
    }

}
