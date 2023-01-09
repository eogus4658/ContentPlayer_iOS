//
//  ContentListViewController.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/09.
//

import UIKit

class ContentListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    
    private var contentData: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    private func setCollectionView() {
        loadContent()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func loadContent() {
        guard let path = Bundle.main.path(forResource: "content_list", ofType: "json"),
              let json = try? String(contentsOfFile: path)
        else {
            return
        }
        contentData = JsonManager.shared.parse(type: Contents.self, json: json).Contents
    }
    
    private func setContentInfo(_ content: Content) {
        self.genreLabel.text = content.Genre
        self.titleLabel.text = content.Name
        self.descriptionLabel.text = content.Description
        self.qualityLabel.text = content.Definition
    }
}

extension ContentListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentListCollectionView", for: indexPath) as? ContentListViewCell else {
            return UICollectionViewCell()
        }
        cell.set(contentData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.setContentInfo(contentData[indexPath.row])
    }
}
