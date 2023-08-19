//
//  EpisodesTableViewCell.swift
//  RickAndMorty
//
//  Created by Ravil on 19.08.2023.
//

import UIKit
import SnapKit

final class EpisodesTableViewCell: UITableViewCell {

    static let reuseID = String(describing: EpisodesTableViewCell.self)
    
    // MARK: - UI
    
    private lazy var episodeCardView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.grayBG.uiColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    public lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilot"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    public lazy var episodeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Episode: 1, Season: 1"
        label.textColor = AppColor.primaryBG.uiColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    public lazy var dataSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "December 2, 2013"
        label.textColor = AppColor.grayTextBG.uiColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
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
        [episodeCardView, episodeLabel, episodeSubtitleLabel, dataSubtitleLabel].forEach {
            contentView.addSubview($0)
        }
    }

    // MARK: - setupConstraints

    private func setupConstraints() {
        episodeCardView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(86)
        }
        episodeLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeCardView.snp.top).offset(16)
            make.leading.equalTo(episodeCardView.snp.leading).offset(15)
        }
        episodeSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeCardView.snp.top).offset(54)
            make.leading.equalTo(episodeCardView.snp.leading).offset(15)
        }
        dataSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeCardView.snp.top).offset(54)
            make.trailing.equalTo(episodeCardView.snp.trailing).offset(-15)
        }
    }
    
    // MARK: - Actions
    
    public func configureEpisode(with episode: Episode) {
        episodeLabel.text = episode.name
        episodeSubtitleLabel.text = "Episode: \(episode.episode)"
        dataSubtitleLabel.text = episode.airDate
    }

}
