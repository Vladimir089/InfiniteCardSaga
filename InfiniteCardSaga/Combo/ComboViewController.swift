//
//  ComboViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 19.07.2024.
//

import UIKit

class ComboViewController: UIViewController {
    
    let comboArr: [comboModel] = [comboModel(name: "Royal Flush", text: "5 cards from ten to ace of the same suit. Highest hand in poker", image: .combo1), comboModel(name: "Straight Flush", text: "Any five consecutive cards of the same suit", image: .combo2), comboModel(name: "Four of a Kind", text: "Any four cards of the same rank", image: .combo3), comboModel(name: "Full Hause", text: "Three cards of one rank and two cards of another rank", image: .combo4), comboModel(name: "Flush", text: "Five cards of the same suit", image: .combo5), comboModel(name: "Straight", text: "Five consecutive cards", image: .combo6), comboModel(name: "Three of a kind", text: "Three cards of the same rank", image: .combo7), comboModel(name: "Two pair", text: "Two cards of one rank and two cards of another rank", image: .combo8), comboModel(name: "Pair", text: "Two cards of the same rank", image: .combo9), comboModel(name: "High card", text: "Any high card. Lowest poker hand", image: .combo10)]
    
    var collection: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 18/255, green: 25/255, blue: 28/255, alpha: 1)
        createInterface()
    }
    

    func createInterface() {
        
        let labelMain: UILabel = {
            let label = UILabel()
            label.text = "Combination"
            label.font = .systemFont(ofSize: 36, weight: .bold)
            label.textColor = .white
            return label
        }()
        view.addSubview(labelMain)
        labelMain.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(15)
        }
        
        collection = {
            let layout = UICollectionViewFlowLayout()
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "main")
            collection.backgroundColor = .clear
            collection.showsVerticalScrollIndicator = false
            layout.scrollDirection = .vertical
            collection.delegate = self
            collection.dataSource = self
            return collection
        }()
        view.addSubview(collection!)
        collection?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(labelMain.snp.bottom).inset(-10)
        })
        
    }

}

extension ComboViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comboArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        
        cell.backgroundColor = .white.withAlphaComponent(0.04)
        cell.layer.cornerRadius = 16
        
        let numberTextButton = UIButton()
        numberTextButton.backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1)
        numberTextButton.layer.cornerRadius = 6
        numberTextButton.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        numberTextButton.setTitleColor(.white, for: .normal)
        numberTextButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        if indexPath.row + 1 != 10 {
            numberTextButton.setTitle("0\(indexPath.row + 1)", for: .normal)
        } else {
            numberTextButton.setTitle("\(indexPath.row + 1)", for: .normal)
        }
        cell.addSubview(numberTextButton)
        numberTextButton.snp.makeConstraints { make in
            make.height.width.equalTo(28)
            make.left.top.equalToSuperview().inset(20)
        }
        
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.text = comboArr[indexPath.row].name
        nameLabel.textAlignment = .left
        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(numberTextButton)
            make.left.equalTo(numberTextButton.snp.right).inset(-10)
        }
        
        let descLabel = UILabel()
        descLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descLabel.textColor = .white.withAlphaComponent(0.8)
        descLabel.text = comboArr[indexPath.row].text
        descLabel.numberOfLines = 2
        descLabel.textAlignment = .left
        cell.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(numberTextButton.snp.right).inset(-10)
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
        }
        
        let imageView = UIImageView(image: comboArr[indexPath.row].image)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        cell.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(252)
            make.bottom.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 172)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 15, right: 0)
    }
    
}



struct comboModel {
    var name: String
    var text: String
    var image: UIImage
    
    init(name: String, text: String, image: UIImage) {
        self.name = name
        self.text = text
        self.image = image
    }
}
