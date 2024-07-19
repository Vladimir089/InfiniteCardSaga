//
//  PostsViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import UIKit

protocol PostsViewControllerDelegate: AnyObject {
    func reload()
}

class PostsViewController: UIViewController {
    
    var noPostsView: UIView?
    var collection: UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createInterface()
        view.backgroundColor = UIColor(red: 18/255, green: 25/255, blue: 28/255, alpha: 1)
        checkArr()
        print(postsArr)
    }
    
    func createInterface() {
        
        let labelMain: UILabel = {
            let label = UILabel()
            label.text = "Posts"
            label.font = .systemFont(ofSize: 36, weight: .bold)
            label.textColor = .white
            return label
        }()
        view.addSubview(labelMain)
        labelMain.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(15)
        }
        
        let newPostButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1)
            button.layer.cornerRadius = 18
            
            let label = UILabel()
            label.text = "New post"
            label.textColor = .white
            label.font = .systemFont(ofSize: 12, weight: .semibold)
            button.addSubview(label)
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(7)
            }
            
            let imageView = UIImageView(image: .addPost)
            imageView.contentMode = .scaleAspectFit
            button.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.height.width.equalTo(20)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(7)
            }
            return button
        }()
        view.addSubview(newPostButton)
        newPostButton.addTarget(self, action: #selector(createNewPost), for: .touchUpInside)
        newPostButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(96)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalTo(labelMain)
        }
        
        
        noPostsView = {
            let view = UIView()
            view.backgroundColor = .white.withAlphaComponent(0.04)
            view.layer.cornerRadius = 20
            
            let label = UILabel()
            label.text = "Empty"
            label.textColor = .white
            label.font = .systemFont(ofSize: 22, weight: .bold)
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().inset(30)
            }
            
            let labelTwo = UILabel()
            labelTwo.text = "You don't have any posts written"
            labelTwo.textColor = .white.withAlphaComponent(0.5)
            labelTwo.font = .systemFont(ofSize: 15, weight: .regular)
            view.addSubview(labelTwo)
            labelTwo.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(label.snp.bottom).inset(-5)
            }
            
            let newPostButton = UIButton(type: .system)
            newPostButton.setTitle("New post", for: .normal)
            newPostButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            newPostButton.setTitleColor(.white, for: .normal)
            newPostButton.backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1)
            newPostButton.layer.cornerRadius = 12
            
            view.addSubview(newPostButton)
            newPostButton.snp.makeConstraints { make in
                make.height.equalTo(50)
                make.width.equalTo(154)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(30)
            }
            newPostButton.addTarget(self, action: #selector(createNewPost), for: .touchUpInside)
            return view
        }()
        view.addSubview(noPostsView!)
        noPostsView?.snp.makeConstraints({ make in
            make.height.equalTo(185)
            make.left.right.equalToSuperview().inset(30)
            make.centerX.centerY.equalToSuperview()
        })
        
        collection = {
            let layout = UICollectionViewFlowLayout()
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "main")
            collection.dataSource = self
            collection.delegate = self
            collection.backgroundColor = .clear
            collection.showsVerticalScrollIndicator = false
            return collection
        }()
        view.addSubview(collection!)
        collection?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(newPostButton.snp.bottom).inset(-15)
        })
        
    }
    
    func checkArr() {
        if postsArr.count == 0 {
            collection?.alpha = 0
            noPostsView?.alpha = 1
        } else {
            collection?.alpha = 1
            noPostsView?.alpha = 0
        }
        collection?.reloadData()
    }
    
    @objc func createNewPost() {
        let vc = NewPostViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func decodeDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date)
    }

}

extension PostsViewController: PostsViewControllerDelegate {
    func reload() {
        checkArr()
    }
}


extension PostsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        cell.backgroundColor = .white.withAlphaComponent(0.04)
        cell.layer.cornerRadius = 16
        
        let dateLabel = UILabel()
        dateLabel.textColor = .white.withAlphaComponent(0.5)
        dateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        let newDate = decodeDate(date: postsArr[indexPath.row].date)
        dateLabel.text = newDate
        cell.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(20)
        }
        
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.text = postsArr[indexPath.row].title
        nameLabel.numberOfLines = 3

        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(dateLabel.snp.bottom).inset(-5)
            make.height.equalTo(72)
        }
        
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .regular)
        textLabel.textColor = .white.withAlphaComponent(0.5)
        textLabel.text = postsArr[indexPath.row].text
        textLabel.numberOfLines = 2
        cell.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 166)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailPostViewController()
        vc.delegate = self
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
