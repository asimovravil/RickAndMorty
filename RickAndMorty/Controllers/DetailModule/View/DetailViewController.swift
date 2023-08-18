//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    var location: Location?
    var character: Character?
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        let screenHeight = UIScreen.main.bounds.height
        tableView.rowHeight = screenHeight
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
        fetchLocationDetails()
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
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EpisodesTableViewCell.reuseID,
            for: indexPath
        ) as? EpisodesTableViewCell else {
            fatalError("Could not cast to LocalizationViewCell")
        }
        
        if let character = character {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: character.image),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cell.characterDetailImageView.image = image
                        cell.characterDetailLabel.text = character.name
                        cell.characterDetailSubtitleLabel.text = character.status
                        cell.descriptionSpeciesLabel.text = character.species
                        if !character.type.isEmpty {
                            cell.descriptionTypeLabel.text = character.type
                        } else {
                            cell.descriptionTypeLabel.text = "None"
                        }
                        cell.descriptionGenderLabel.text = character.gender
                    }
                }
            }
        }

        if let location = location {
            DispatchQueue.main.async {
                cell.originLabel.text = location.name
                cell.originSubtitleLabel.text = location.type
            }
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = AppColor.blackBG.uiColor
        return cell
    }
}
