//
//  UserOnbOneViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import UIKit

class UserOnbOneViewController: UIViewController {
    
    var topOneView, topTwoView: UIView?
    var topLabel, botLabel: UILabel?
    var imageView: UIImageView?
    var nextButton: UIButton?
    
    var tap = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        createInerface()
        view.backgroundColor = UIColor(red: 34/255, green: 53/255, blue: 120/255, alpha: 1)
    }
    
    func createInerface() {
        
        topOneView = createView()
        topOneView?.alpha = 1
        view.addSubview(topOneView!)
        topOneView?.snp.makeConstraints({ make in
            make.height.equalTo(6)
            make.width.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.snp.centerX).offset(-7.5)
        })
        
        topTwoView = createView()
        view.addSubview(topTwoView!)
        topTwoView?.snp.makeConstraints({ make in
            make.height.equalTo(6)
            make.width.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.centerX).offset(7.5)
        })
        
        topLabel = {
            let label = UILabel()
            label.text = "DISCOVER NEW THINGS"
            label.textColor = .white
            label.font = .systemFont(ofSize: 28, weight: .bold)
            label.textAlignment = .center
            label.numberOfLines = 2
            return label
        }()
        
        view.addSubview(topLabel!)
        topLabel?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(25)
            make.top.equalTo(topTwoView!.snp.bottom).inset(-20)
        })
        
        botLabel = {
            let label = UILabel()
            label.textColor = .white.withAlphaComponent(0.6)
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.textAlignment = .center
            label.numberOfLines = 2
            label.text = "Unique rules and hints for the game"
            return label
        }()
        view.addSubview(botLabel!)
        botLabel?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(25)
            make.top.equalTo(topLabel!.snp.bottom).inset(-5)
        })
        
        
        imageView = {
            let imageView = UIImageView(image: .us1)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        view.addSubview(imageView!)
        imageView?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(576)
        })
        
        nextButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.layer.cornerRadius = 12
            button.setTitle("Next", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            button.setTitleColor(UIColor(red: 34/255, green: 53/255, blue: 120/255, alpha: 1), for: .normal)
            return button
        }()
        view.addSubview(nextButton!)
        nextButton?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
        nextButton?.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
    }
    

    @objc func tapped() {
        tap += 1
        switch tap {
        case 1:
            UIView.animate(withDuration: 0.3) { [self] in
                topOneView?.alpha = 0.12
                topTwoView?.alpha = 1
                topLabel?.text = "START WITH A LOT OF CONFIDENCE"
                botLabel?.text = "Learn everything from the beginning"
                imageView?.image = UIImage.us2
            }
        case 2:
            self.navigationController?.setViewControllers([TabBarViewController()], animated: true)
        default:
            break
        }
    }

    
    func createView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        view.alpha = 0.12
        return view
    }
    
    
}
