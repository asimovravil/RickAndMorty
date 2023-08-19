//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    var episode: Episode?
    var location: Location?
    var character: Character?
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        let screenHeight = UIScreen.main.bounds.height
        tableView.rowHeight = screenHeight
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseID)
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
        fetchLocationDetails()
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
    
    private func fetchLocationDetails() {
        LocationService.fetchLocations { locations, error in
            if let error = error {
                print("Error fetching locations: \(error)")
                return
            }
            
            if let locations = locations, let firstLocation = locations.first {
                self.location = firstLocation
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func fetchEpisodeDetails() {
        EpisodeService.fetchEpisodes { episodes, error in
            if let error = error {
                print("Error fetching episodes: \(error)")
                return
            }
            
            if let episodes = episodes, let firstEpisode = episodes.first {
                self.episode = firstEpisode
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailTableViewCell.reuseID,
            for: indexPath
        ) as? DetailTableViewCell else {
            fatalError("Could not cast to LocalizationViewCell")
        }
        
        if let character = character {
            cell.configureCharacter(with: character)
        }

        if let location = location {
            DispatchQueue.main.async {
                cell.configureLocation(with: location)
            }
        }
        
        if let episode = episode {
            DispatchQueue.main.async {
                cell.configureEpisode(with: episode)
            }
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = AppColor.blackBG.uiColor
        return cell
    }
}
