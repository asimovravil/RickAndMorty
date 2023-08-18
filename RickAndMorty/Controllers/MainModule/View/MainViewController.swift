//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Ravil on 17.08.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private var locations: [Location] = []
    private var characters: [Character] = []
    let sections: [SectionType] = [.main]
    
    // MARK: - UI
    
    private lazy var chatacterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.textColor = AppColor.whiteBG.uiColor
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseID)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        fetchCharacterData()
    }

    // MARK: - setupViews
    
    private func setupViews() {
        view.addSubview(chatacterTitleLabel)
        view.addSubview(mainCollectionView)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = AppColor.blackBG.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        chatacterTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(24)
        }
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chatacterTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - createLayout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .main
            switch section {
            case .main:
                return self?.mainSectionLayout()
            }
        }
    }
    
    private func fetchCharacterData() {
        CharacterService.fetchCharacters { characters, error in
            if let error = error {
                // Handle error here
                print("Error fetching characters: \(error)")
                return
            }
            
            if let characters = characters {
                self.characters = characters
                DispatchQueue.main.async {
                    self.mainCollectionView.reloadData()
                }
            }
        }
    }

    
    // MARK: - sectionLayout
    
    private func mainSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(156),
                heightDimension: .absolute(202)
            )
        )
        item.contentInsets.trailing = 20
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(180)
            ),
            subitem: item,
            count: 2
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 40
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 10,
            trailing: -16
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCollectionViewCell.reuseID,
                for: indexPath
            ) as? MainCollectionViewCell else {
                fatalError("Could not cast to MainCollectionViewCell")
            }
            
            let character = characters[indexPath.item]
            cell.configure(with: character)
            
            cell.characterButtonTappedHandler = {
                let detailViewController = DetailViewController()
                detailViewController.character = character
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .main:
            return characters.count
        }
    }
}
