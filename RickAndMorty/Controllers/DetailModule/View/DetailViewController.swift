//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
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

        
        cell.selectionStyle = .none
        cell.backgroundColor = AppColor.blackBG.uiColor
        return cell
    }
}
