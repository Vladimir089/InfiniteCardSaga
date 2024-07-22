//
//  EditStatViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 22.07.2024.
//

import UIKit

class EditStatViewController: UIViewController {
    
    weak var delegate: StatViewControllerDelegate?
    
    var numberPostsTextField, myGamesTextField, myVictoriesTextField, winTextField, lostTextField: UITextField?
    var saveButton: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 18/255, green: 25/255, blue: 28/255, alpha: 1)
        createInterface()
        loadData()
    }
    
    
    func loadData() {
        numberPostsTextField?.text = stat?.posts as? String
        myGamesTextField?.text = stat?.games as? String
        myVictoriesTextField?.text = stat?.victories as? String
        winTextField?.text = stat?.won as? String
        lostTextField?.text = stat?.lost as? String
        checkButton()
    }
    
    @objc func saveData() {

        let winText = winTextField?.text?.replacingOccurrences(of: ",", with: ".") ?? ""
           let lostText = lostTextField?.text?.replacingOccurrences(of: ",", with: ".") ?? ""

           let numberPosts = Int(numberPostsTextField?.text ?? "") ?? 0
           let myGames = Int(myGamesTextField?.text ?? "") ?? 0
           let myVictories = Int(myVictoriesTextField?.text ?? "") ?? 0
           let win = Double(winText) ?? 0.0
           let lost = Double(lostText) ?? 0.0

           // Создание объекта Stat
           let ddata = Stat(posts: numberPosts, games: myGames, victories: myVictories, won: win, lost: lost)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(ddata)
            stat = ddata
            delegate?.reload()
            self.navigationController?.popViewController(animated: true)
            UserDefaults.standard.set(data, forKey: "stat")
        } catch {
            print("Ошибка при кодировании постов: \(error)")
        }
    }
    

    func createInterface() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
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
        topLabel.text = "Data editing"
        topLabel.textColor = .white
        topLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
       
        
        let collection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.showsVerticalScrollIndicator = false
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "main")
            collection.backgroundColor = .clear
            collection.delegate = self
            collection.dataSource = self
            return collection
        }()
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(backButton.snp.bottom).inset(-10)
        }
        
        saveButton = {
            let butoon = UIButton(type: .system)
            butoon.layer.cornerRadius = 12
            butoon.setTitle("SAVE", for: .normal)
            butoon.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            butoon.setTitleColor(.white, for: .normal)
            butoon.backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1)
            return butoon
        }()
        view.addSubview(saveButton!)
        saveButton?.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
        saveButton?.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    
    func checkButton() {
        if numberPostsTextField?.text?.count ?? 0 > 0, myGamesTextField?.text?.count ?? 0 > 0, myVictoriesTextField?.text?.count ?? 0 > 0, winTextField?.text?.count ?? 0 > 0, lostTextField?.text?.count ?? 0 > 0 {
            saveButton?.isEnabled = true
            saveButton?.alpha = 1
        } else {
            saveButton?.isEnabled = false
            saveButton?.alpha = 0.5
        }
    }
    
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        
        let placeholderColor = UIColor.white.withAlphaComponent(0.5)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.textColor = .white
        textField.backgroundColor = .white.withAlphaComponent(0.04)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 12
        textField.delegate = self
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
        textField.layer.borderWidth = 0.33
        textField.keyboardType = .numberPad
        return textField
    }
    
    @objc func goBack() {
        delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func hideKeyboard() {
        checkButton()
        view.endEditing(true)
    }

}


extension EditStatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        cell.backgroundColor = .white.withAlphaComponent(0.04)
        cell.layer.cornerRadius = 16
        
        if indexPath.row == 0 {
            
            let postLabel = createLabel(text: "Number of posts")
            cell.addSubview(postLabel)
            postLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.left.equalToSuperview().inset(15)
            }
            
            numberPostsTextField = createTextField(placeholder: "0")
            numberPostsTextField?.keyboardType = .numberPad
            cell.addSubview(numberPostsTextField!)
            numberPostsTextField?.snp.makeConstraints({ make in
                make.height.equalTo(54)
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(postLabel.snp.bottom).inset(-10)
            })
            
            
            let gamesLabel = createLabel(text: "My Games")
            cell.addSubview(gamesLabel)
            gamesLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(15)
                make.top.equalTo(numberPostsTextField!.snp.bottom).inset(-15)
            }
            myGamesTextField = createTextField(placeholder: "0")
            cell.addSubview(myGamesTextField!)
            myGamesTextField?.snp.makeConstraints({ make in
                make.height.equalTo(54)
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(gamesLabel.snp.bottom).inset(-10)
            })
            
            
            let winsLabel = createLabel(text: "My victories")
            cell.addSubview(winsLabel)
            winsLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(15)
                make.top.equalTo(myGamesTextField!.snp.bottom).inset(-15)
            }
            
            myVictoriesTextField = createTextField(placeholder: "0")
            cell.addSubview(myVictoriesTextField!)
            myVictoriesTextField?.snp.makeConstraints({ make in
                make.height.equalTo(54)
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(winsLabel.snp.bottom).inset(-10)
            })
            
            
        } else {
            
            let winLabel = createLabel(text: "Money won")
            cell.addSubview(winLabel)
            winLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.left.equalToSuperview().inset(15)
            }
            winTextField = createTextField(placeholder: "$0.00")
            cell.addSubview(winTextField!)
            winTextField?.keyboardType = .decimalPad
            winTextField?.snp.makeConstraints({ make in
                make.height.equalTo(54)
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(winLabel.snp.bottom).inset(-10)
            })
            
            let lostLabel = createLabel(text: "Lost money")
            cell.addSubview(lostLabel)
            lostLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(15)
                make.top.equalTo(winTextField!.snp.bottom).inset(-15)
            }
            lostTextField = createTextField(placeholder: "$0.00")
            cell.addSubview(lostTextField!)
            lostTextField?.keyboardType = .decimalPad
            lostTextField?.snp.makeConstraints({ make in
                make.height.equalTo(54)
                make.left.right.equalToSuperview().inset(15)
                make.top.equalTo(lostLabel.snp.bottom).inset(-10)
            })
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.bounds.width, height: 310)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 212)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 82, right: 0)
    }
    
    
}


extension EditStatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkButton()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        checkButton()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == winTextField ||  textField == lostTextField {
            UIView.animate(withDuration: 0.3) {
                  self.view.transform = .identity
              }
        }
        
        checkButton()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkButton()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == winTextField ||  textField == lostTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -200)
                
            }
        }
    }
}
