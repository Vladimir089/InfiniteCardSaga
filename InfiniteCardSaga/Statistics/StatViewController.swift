//
//  StatViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 20.07.2024.
//

import UIKit

protocol StatViewControllerDelegate: AnyObject {
    func reload()
}

class StatViewController: UIViewController {
    
    var postsNumberLabel, myGamesLabel, myVictoriesLabel, winsLabel, lostLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 18/255, green: 25/255, blue: 28/255, alpha: 1)
        createInterface()
    }
    

    func createInterface() {
        
        let labelMain: UILabel = {
            let label = UILabel()
            label.text = "Statistics"
            label.font = .systemFont(ofSize: 36, weight: .bold)
            label.textColor = .white
            return label
        }()
        view.addSubview(labelMain)
        labelMain.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(15)
        }
        
        
        let newStatButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1)
            button.layer.cornerRadius = 18
            
            let label = UILabel()
            label.text = "Edit data"
            label.textColor = .white
            label.font = .systemFont(ofSize: 12, weight: .semibold)
            button.addSubview(label)
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(7)
            }
            
            let imageView = UIImageView(image: .edit)
            imageView.contentMode = .scaleAspectFit
            button.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.height.width.equalTo(16)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(7)
            }
            return button
        }()
        view.addSubview(newStatButton)
        newStatButton.addTarget(self, action: #selector(openEdit), for: .touchUpInside)
        newStatButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(96)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalTo(labelMain)
        }
        
        
        let numberView = createBackView()
        view.addSubview(numberView)
        numberView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(82)
            make.top.equalTo(newStatButton.snp.bottom).inset(-20)
        }
        
        let postsTextLabel = createLabels(font: .systemFont(ofSize: 14, weight: .regular), text: "Number of posts", color: .white.withAlphaComponent(0.8))
        numberView.addSubview(postsTextLabel)
        postsTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }
        
        postsNumberLabel = createLabels(font: .systemFont(ofSize: 28, weight: .bold), text: "\(stat?.posts ?? 0)", color: .white)
        numberView.addSubview(postsNumberLabel!)
        postsNumberLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        })
        
        
        let gamesView = createBackView()
        view.addSubview(gamesView)
        gamesView.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.left.equalToSuperview().inset(15)
            make.right.equalTo(view.snp.centerX).offset(-7.5)
            make.top.equalTo(numberView.snp.bottom).inset(-15)
        }
        let gamesTextLabel = createLabels(font: .systemFont(ofSize: 14, weight: .regular), text: "My Games", color: .white.withAlphaComponent(0.8))
        gamesView.addSubview(gamesTextLabel)
        gamesTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }

        myGamesLabel = createLabels(font: .systemFont(ofSize: 28, weight: .bold), text: "\(stat?.games ?? 0)", color: .white)
        gamesView.addSubview(myGamesLabel!)
        myGamesLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        })
        
        
        let victoriesView = createBackView()
        view.addSubview(victoriesView)
        victoriesView.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.top.equalTo(numberView.snp.bottom).inset(-15)
            make.right.equalToSuperview().inset(15)
            make.left.equalTo(view.snp.centerX).offset(7.5)
        }
        let victoriesTextLabel = createLabels(font: .systemFont(ofSize: 14, weight: .regular), text: "My victories", color: .white.withAlphaComponent(0.8))
        victoriesView.addSubview(victoriesTextLabel)
        victoriesTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }
        myVictoriesLabel = createLabels(font: .systemFont(ofSize: 28, weight: .bold), text: "\(stat?.victories ?? 0)", color: .white)
        victoriesView.addSubview(myVictoriesLabel!)
        myVictoriesLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        })
        
        let wonView = createBackView()
        view.addSubview(wonView)
        wonView.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(victoriesView.snp.bottom).inset(-15)
        }
        let winsTextLabel = createLabels(font: .systemFont(ofSize: 14, weight: .regular), text: "Money won", color: .white.withAlphaComponent(0.8))
        wonView.addSubview(winsTextLabel)
        winsTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }
        winsLabel = createLabels(font: .systemFont(ofSize: 28, weight: .bold), text: "+$\(stat?.won ?? 0.00)0", color: .systemGreen)
        wonView.addSubview(winsLabel!)
        winsLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        })
        
        
        let lostView = createBackView()
        view.addSubview(lostView)
        lostView.snp.makeConstraints { make in
            make.height.equalTo(82)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(wonView.snp.bottom).inset(-15)
        }
        let lostTextLabel = createLabels(font: .systemFont(ofSize: 14, weight: .regular), text: "Lost money", color: .white.withAlphaComponent(0.8))
        lostView.addSubview(lostTextLabel)
        lostTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
        }
        lostLabel = createLabels(font: .systemFont(ofSize: 28, weight: .bold), text: "-$\(stat?.lost ?? 0.00)0", color: .systemRed)
        lostView.addSubview(lostLabel!)
        lostLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        })
        
    }
    
    @objc func openEdit() {
        let vc = EditStatViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func createBackView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.04)
        view.layer.cornerRadius = 12
        return view
    }
    
    func createLabels(font: UIFont, text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }

    
}

extension StatViewController: StatViewControllerDelegate {
    func reload() {
        postsNumberLabel?.text = "\(stat?.posts ?? 0)"
        myGamesLabel?.text = "\(stat?.games ?? 0)"
        myVictoriesLabel?.text = "\(stat?.victories ?? 0)"
        winsLabel?.text = "+$\(stat?.won ?? 0.00)0"
        lostLabel?.text = "-$\(stat?.lost ?? 0.00)0"
    }
}


struct Stat: Codable {
    var posts: Int
    var games: Int
    var victories: Int
    var won: Double
    var lost: Double
    
    init(posts: Int, games: Int, victories: Int, won: Double, lost: Double) {
        self.posts = posts
        self.games = games
        self.victories = victories
        self.won = won
        self.lost = lost
    }
}
