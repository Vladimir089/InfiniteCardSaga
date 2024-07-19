//
//  DetailPostViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 19.07.2024.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    weak var delegate: PostsViewControllerDelegate?
    var index = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 18/255, green: 25/255, blue: 28/255, alpha: 1)
        createInterface()
    }
    

    func createInterface() {
        let backButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(.backArrow.resize(targetSize: CGSize(width: 17, height: 17)), for: .normal)
            button.tintColor = .white
            button.backgroundColor = .white.withAlphaComponent(0.04)
            button.layer.cornerRadius = 12
            return button
        }()
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(15)
        }
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let topLabel = UILabel()
        topLabel.text = "Post"
        topLabel.textColor = .white
        topLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
        let delButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(.del.resize(targetSize: CGSize(width: 17, height: 17)), for: .normal)
            button.tintColor = .white
            button.backgroundColor = .white.withAlphaComponent(0.04)
            button.layer.cornerRadius = 12
            return button
        }()
        view.addSubview(delButton)
        delButton.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().inset(15)
        }
        delButton.addTarget(self, action: #selector(delPost), for: .touchUpInside)
        
        let dateLabel: UIButton = {
            let button = UIButton()
            button.setTitle(decodeDate(date: postsArr[index].date), for: .normal)
            button.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
            button.backgroundColor = .white.withAlphaComponent(0.08)
            button.layer.cornerRadius = 4
            button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
            return button
        }()
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(backButton.snp.bottom).inset(-15)
        }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = postsArr[index].title
            label.numberOfLines = 3
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(dateLabel.snp.bottom).inset(-15)
        }
        
        let textLabel = UILabel()
        textLabel.text = postsArr[index].text
        textLabel.textColor = .white.withAlphaComponent(0.8)
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
        
        
    }
    
    
    @objc func delPost() {
        
        postsArr.remove(at: index)

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(postsArr)
            UserDefaults.standard.set(data, forKey: "postss")
            delegate?.reload()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Ошибка при кодировании постов: \(error)")
        }

    }
    
    @objc func goBack() {
        delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
    
    func decodeDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date)
    }

}
