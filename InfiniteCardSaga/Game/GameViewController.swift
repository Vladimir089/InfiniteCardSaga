//
//  GameViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    var selected = "Start"
    
    var buttonsArr: [UIButton] = []
    var collection: UICollectionView?
    
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
        
        let labelMain: UILabel = {
            let label = UILabel()
            label.text = "Game"
            label.font = .systemFont(ofSize: 36, weight: .bold)
            label.textColor = .white
            return label
        }()
        view.addSubview(labelMain)
        labelMain.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(15)
        }
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 10
            stack.distribution = .fillEqually
            return stack
        }()
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(labelMain.snp.bottom).inset(-15)
            make.height.equalTo(38)
        }
        
        let startButton = createButtons(text: "Start")
        let flopButton = createButtons(text: "Flop")
        let thornButton = createButtons(text: "Thorn")
        let riverButton = createButtons(text: "River")
        let kickerButton = createButtons(text: "Kicker")
        
        buttonsArr.append(startButton)
        buttonsArr.append(flopButton)
        buttonsArr.append(thornButton)
        buttonsArr.append(riverButton)
        buttonsArr.append(kickerButton)
        
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(flopButton)
        stackView.addArrangedSubview(thornButton)
        stackView.addArrangedSubview(riverButton)
        stackView.addArrangedSubview(kickerButton)
        
        collection = {
            let layout = UICollectionViewFlowLayout()
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "main")
            collection.backgroundColor = .clear
            collection.showsVerticalScrollIndicator = false
            collection.delegate = self
            collection.dataSource = self
            return collection
        }()
        view.addSubview(collection!)
        collection?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).inset(-10)
            
        })
        
    }
    
    @objc func buttonTapped(sender: UIButton) {
        selected = sender.titleLabel?.text ?? ""
        
        for i in buttonsArr {
            if i.backgroundColor == UIColor(red: 34/255, green: 53/255, blue: 120/255, alpha: 1) {
                i.layer.borderColor = .none
                i.layer.borderWidth = 0
                i.backgroundColor = .white.withAlphaComponent(0.04)
            }
        }
        
        sender.backgroundColor = UIColor(red: 34/255, green: 53/255, blue: 120/255, alpha: 1)
        sender.layer.borderColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1).cgColor
        sender.layer.borderWidth = 1.5
        collection?.reloadData()
    }
    
    func createButtons(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.04)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        if text == "Start" {
            button.backgroundColor = UIColor(red: 34/255, green: 53/255, blue: 120/255, alpha: 1)
            button.layer.borderColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1).cgColor
            button.layer.borderWidth = 1.5
        }
        return button
    }
   

}


extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        
        let labelTop = UILabel()
        labelTop.textColor = .white
        labelTop.font = .systemFont(ofSize: 15, weight: .regular)
        labelTop.numberOfLines = 0
        cell.addSubview(labelTop)
        labelTop.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        cell.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(labelTop.snp.bottom).inset(-15)
            make.height.equalTo(397)
        }
        
        let botLabel = UILabel()
        botLabel.textColor = .white
        botLabel.font = .systemFont(ofSize: 15, weight: .regular)
        botLabel.numberOfLines = 0
        cell.addSubview(botLabel)
        botLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).inset(-15)
        }
        
        switch selected {
            
        case "Start":
            labelTop.text = "Hold'em can be played by two to ten players at the same table. The figure shows a typical landing for this type of poker. In this example, there are three players sitting at the table."
            imageView.image = UIImage.start
            botLabel.text = """
            Next, each player is dealt two cards face down (his hand) and the trading round begins.
            
            After the player has assessed his chances of winning, he can do the following:
            
            • equalize (call) - equalize the bet.
            • fold - if a player is not ready to play with the cards he has, he can fold them and wait for the next hand.
            • raise - the player raises the bet/makes a bet more than the maximum amount placed on the table.
            • re-raise (reraise) - a player raises the bet in response to another player raising the bet
            • all-in (all-in) - the player bets all his available chips.
            • agree (check) - if the player does not want to bet anything and his current bet is equal to the maximum on the table, he can agree.
            
            The right to take action passes to the players clockwise. The player sitting to the left of the big blind moves first, and the big blind,
            respectively, moves last.
            
            The trading round ends when all the players who want to continue the game have leveled the highest bet. If no one has raised the maximum bet
            in the trading round, then the player, the one who made it is considered the winner and takes the whole pot.
            """
            
        case "Flop":
            labelTop.text = "3 cards are laid out on the table in the open, which are called the Flop."
            imageView.image = UIImage.flop
            imageView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(labelTop.snp.bottom).inset(-15)
                make.height.equalTo(198)
            }
            botLabel.text = """
            Players can now make combinations by strengthening their starting hand.
            
            The second round of trading begins. The right to move is given to all active players in turn, also clockwise. The player sitting to the left
            of the dealer moves first, if he has thrown off the cards, then the right turn moves clockwise to the first active player. The trading rules
            are the same as in the first round
            """
            
        case "Thorn":
            labelTop.text = "Another card is laid out on the table in the open."
            imageView.image = UIImage.thorn
            imageView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(labelTop.snp.bottom).inset(-15)
                make.height.equalTo(198)
            }
            botLabel.text = "Now players can make five-card combinations out of the six cards they have. The third round of trading begins, identical to the previous one."
            
        case "River":
            labelTop.text = "The last card is laid out on the table in the open."
            imageView.image = UIImage.river
            imageView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(labelTop.snp.bottom).inset(-15)
                make.height.equalTo(198)
            }
            botLabel.text = """
            The fourth/last round of trading begins.
            
            The players make their last bets and actions before the showdown. All the cards open. The player who made the last bet opens his hand
            first.( if there were no bets, the player who is clockwise from the dealer opens first ) The combinations of the players are compared and a
            decision is made on the winner. The strongest combination wins.
            """
            
        case "Kicker":
            labelTop.text = """
            A kicker is a card that is not included in a poker combination, but is significant if two players have the same combinations. A kicker (one
            or more) has the following combinations: Pair, Two pairs, Three of a Kind, Four of a Kind.
            
            Let's give an example:
            """
            imageView.image = UIImage.kicker
            imageView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(labelTop.snp.bottom).inset(-15)
                make.height.equalTo(286)
            }
            botLabel.text = """
            Both players have a "pair of sevens" combination, but since the first one has an ace kicker and the second one has a king, the first player 
            takes the bank.
            """
            
        default:
            print(1)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch selected {
        case "Start":
            return CGSize(width: collectionView.frame.width, height: 1085)
        case "Flop":
            return CGSize(width: collectionView.frame.width, height: 503)
        case "Thorn":
            return CGSize(width: collectionView.frame.width, height: 346)
        case "River":
            return CGSize(width: collectionView.frame.width, height: 482)
        case "Kicker":
            return CGSize(width: collectionView.frame.width, height: 596)
        default:
            return CGSize(width: collectionView.frame.width, height: 596)
        }
    }
    
    
}
