//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    private var episodes: [Episode] = []
    var location: Location?
    var character: Character?
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        let screenHeight = UIScreen.main.bounds.height
        tableView.rowHeight = screenHeight
        tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.reuseID)
        tableView.register(LocationsTableViewCell.self, forCellReuseIdentifier: LocationsTableViewCell.reuseID)
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.reuseID)
        tableView.backgroundColor = AppColor.blackBG.uiColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchEpisodeDetails()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [tableView].forEach {
            view.addSubview($0)
        }
        
        view.backgroundColor = AppColor.blackBG.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func fetchEpisodeDetails() {
        EpisodeService.fetchEpisodes { episodes, error in
            if let error = error {
                print("Error fetching episodes: \(error)")
                return
            }
            
            if let episodes = episodes {
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return episodes.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let detailCell = tableView.dequeueReusableCell(
                withIdentifier: CharactersTableViewCell.reuseID,
                for: indexPath
            ) as? CharactersTableViewCell else {
                fatalError("Could not cast to DetailTableViewCell")
            }
            if let character = character {
                detailCell.configureCharacter(with: character)
            }
            detailCell.selectionStyle = .none
            detailCell.backgroundColor = AppColor.blackBG.uiColor
            return detailCell
        } else if indexPath.section == 1 {
            guard let locationsCell = tableView.dequeueReusableCell(
                withIdentifier: LocationsTableViewCell.reuseID,
                for: indexPath
            ) as? LocationsTableViewCell else {
                fatalError("Could not cast to LocationsTableViewCell")
            }
            if let location = location {
                locationsCell.configureLocation(with: location)
            }
            if indexPath.row == 0 {
                locationsCell.episodesTitleLabel.isHidden = false
            } else {
                locationsCell.episodesTitleLabel.isHidden = true
            }
            locationsCell.selectionStyle = .none
            locationsCell.backgroundColor = AppColor.blackBG.uiColor
            return locationsCell
        } else if indexPath.section == 2 {
            guard let episodesCell = tableView.dequeueReusableCell(
                withIdentifier: EpisodesTableViewCell.reuseID,
                for: indexPath
            ) as? EpisodesTableViewCell else {
                fatalError("Could not cast to EpisodesTableViewCell")
            }
            episodesCell.configureEpisode(with: episodes[indexPath.row])
            episodesCell.selectionStyle = .none
            episodesCell.backgroundColor = AppColor.blackBG.uiColor
            return episodesCell
        }
        fatalError("Unexpected section")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 450.0  
        } else if indexPath.section == 1 {
            return 195.0
        } else if indexPath.section == 2 {
            return 105.0
        }
        return UITableView.automaticDimension
    }
}

