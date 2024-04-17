//
//  ViewController.swift
//  PracticleTest
//
//  Created by Shyam Dineshbhai Kalariya on 14/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let unspalshURL = "https://source.unsplash.com/random/200x200/?"
    var imageURLs: [URL] = []
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        //Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImageURLs()
    }
    
    func setCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ImageCell.id, bundle: nil), forCellWithReuseIdentifier: ImageCell.id)
    }
    
    func loadImageURLs() {
        for i in 1...10000 {
            if let imageURL = URL(string: "\(unspalshURL)\(i)") {
                imageURLs.append(imageURL)
            }
        }
    }
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.2, height: collectionView.frame.width / 3.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.id, for: indexPath) as! ImageCell
        
        let imageURL = imageURLs[indexPath.item]
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            cell.imgV.image = cachedImage
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                    DispatchQueue.main.async {
                        cell.imgV.image = image
                    }
                }
            }
        }
        return cell
    }
}
