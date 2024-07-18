//
//  NewPostViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import UIKit

class NewPostViewController: UIViewController {
    
    weak var delegate: PostsViewControllerDelegate?
    
    //ui
    var titleTextField: UITextField?
    var textView: UITextView?
    var createButton: UIButton?
    
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
        topLabel.text = "New post"
        topLabel.textColor = .white
        topLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
        let titleLabel = createLabel(text: "Title")
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(backButton.snp.bottom).inset(-30)
        }
        
        titleTextField = {
            let textField = UITextField()
            textField.borderStyle = .none
            textField.backgroundColor = .white.withAlphaComponent(0.04)
            textField.layer.cornerRadius = 12
            textField.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
            textField.layer.borderWidth = 0.33
            textField.delegate = self
            textField.textColor = .white
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            textField.leftViewMode = .always
            textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            textField.rightViewMode = .always
            let placeholderText = "Enter..."
            let placeholderColor = UIColor.white.withAlphaComponent(0.5)
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
            return textField
        }()
        view.addSubview(titleTextField!)
        titleTextField?.snp.makeConstraints({ make in
            make.height.equalTo(54)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
        })
        
        
        let textLabel = createLabel(text: "Text")
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(titleTextField!.snp.bottom).inset(-20)
        }
        
        textView = {
            let view = UITextView()
            view.textColor = .white
            view.isEditable = true
            view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            view.backgroundColor = .white.withAlphaComponent(0.04)
            view.layer.cornerRadius = 12
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
            view.layer.borderWidth = 0.33
            return view
        }()
        view.addSubview(textView!)
        textView?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(textLabel.snp.bottom).inset(-15)
            make.height.equalTo(160)
        })
        
        createButton = {
            let button = UIButton(type: .system)
            button.setTitle("CREATE", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            button.isEnabled = false
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 4/255, green: 112/255, blue: 208/255, alpha: 1)
            button.layer.cornerRadius = 12
            button.alpha = 0.5
            return button
        }()
        view.addSubview(createButton!)
        createButton?.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
        createButton?.addTarget(self, action: #selector(createPost), for: .touchUpInside)
    }
    
    @objc func createPost() {
        let post = Post(title: titleTextField?.text ?? "", text: textView?.text ?? "", date: Date())
        postsArr.append(post)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(postsArr)
            UserDefaults.standard.set(data, forKey: "postss")
        } catch {
            print("Ошибка при кодировании постов: \(error)")
        }
        
        goBack()
    }

    @objc func hideKeyboard() {
        checkButton()
        view.endEditing(true)
    }

    @objc func goBack() {
        delegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }
    
    func checkButton() {
        if titleTextField?.text?.count ?? 0 > 0 , textView?.text.count ?? 0 > 0 {
            createButton?.isEnabled = true
            createButton?.alpha = 1
        } else {
            createButton?.isEnabled = false
            createButton?.alpha = 0.5
        }
    }
}


extension NewPostViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkButton()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        checkButton()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        checkButton()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        checkButton()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkButton()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        checkButton()
    }
}
