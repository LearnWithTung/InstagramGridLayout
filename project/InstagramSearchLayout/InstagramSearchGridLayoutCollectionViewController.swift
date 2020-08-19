//
//  InstagramSearchGridLayoutCollectionViewController.swift
//  InstagramSearchLayout
//
//  Created by Tung Vu Duc on 8/18/20.
//

import UIKit

enum SectionType {
    case nestedLeading
    case nestedTrailing
    case gridTwoRow
}

struct Item {
    let imageURL: String
}

struct Section {
    let type: SectionType
    let items: [Item]
}

extension Section {
    static var allSections = [
        Section(type: .nestedLeading, items: [
            Item(imageURL: "image-1"),
            Item(imageURL: "image-2"),
            Item(imageURL: "image-3")
        ]),
        Section(type: .gridTwoRow, items: [
            Item(imageURL: "image-1"),
            Item(imageURL: "image-2"),
            Item(imageURL: "image-3"),
            Item(imageURL: "image-4"),
            Item(imageURL: "image-5"),
            Item(imageURL: "image-6")
        ]),
        Section(type: .nestedTrailing, items: [
            Item(imageURL: "image-1"),
            Item(imageURL: "image-2"),
            Item(imageURL: "image-3")
        ]),
        Section(type: .gridTwoRow, items: [
            Item(imageURL: "image-1"),
            Item(imageURL: "image-2"),
            Item(imageURL: "image-3"),
            Item(imageURL: "image-4"),
            Item(imageURL: "image-5"),
            Item(imageURL: "image-6")
        ])
    ]
}

class InstagramSearchGridLayoutCollectionViewController: UICollectionViewController {
    
    static let dataSource = Section.allSections
    
    init(){
        let layout = UICollectionViewCompositionalLayout {(section, env) -> NSCollectionLayoutSection? in
            let section = InstagramSearchGridLayoutCollectionViewController.dataSource[section]
            if section.type == .nestedTrailing {
                let trailingItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
                
                let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
                
                let leadingItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)))
                
                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/3)), subitems: [leadingItem, trailingGroup])
                
                let section = NSCollectionLayoutSection(group: nestedGroup)
                return section
            } else if section.type == .gridTwoRow{
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else if section.type == .nestedLeading{
                let trailingItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
                
                let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
                
                let leadingItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)))
                
                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/3)), subitems: [trailingGroup, leadingItem])
                
                let section = NSCollectionLayoutSection(group: nestedGroup)
                return section
            }
            return nil
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(InstagramGridCell.self, forCellWithReuseIdentifier: "cellId")
        title = "Instagram"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = InstagramSearchGridLayoutCollectionViewController.dataSource[section]
        return section.items.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return InstagramSearchGridLayoutCollectionViewController.dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = InstagramSearchGridLayoutCollectionViewController.dataSource[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! InstagramGridCell
        cell.layer.borderColor = UIColor.darkText.cgColor
        cell.layer.borderWidth = 0.5
        cell.imageName = item.imageURL
        return cell
    }
    
}
