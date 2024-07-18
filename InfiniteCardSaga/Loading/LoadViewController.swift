//
//  LoadViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import UIKit
import SnapKit

class LoadViewController: UIViewController {
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsVC()
        view.backgroundColor = UIColor(red: 34/255, green: 53/255, blue: 120/255, alpha: 1)
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: false) //менять на 5
        
    }
    

    func settingsVC() {
        
        let logoImageView: UIImageView = {
            let image = UIImage.logoLoading
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(156)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
       
        let activityView: UIActivityIndicatorView = {
            let activity = UIActivityIndicatorView(style: .medium)
            activity.isHidden = false
            activity.color = .white
            return activity
        }()
        view.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        activityView.startAnimating()

    }

    @objc func nextPage() {
        timer?.invalidate()
        timer = nil
        
        if isBet == false {
            if UserDefaults.standard.object(forKey: "tab") != nil {
                //self.navigationController?.setViewControllers([TabBarViewController()], animated: true)
            } else {
                self.navigationController?.setViewControllers([UserOnbOneViewController()], animated: true)
            }
        } else {
            
        }
        
 
    }
    
    
    
    
    
}



