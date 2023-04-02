//
//  WelcomeScreenViewController.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//

import UIKit

final class WelcomeScreenViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "background")
        return image
    }()
    
    private let ovarlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.text = "Listen to millions \nof songs on\n the go!"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign in with spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Spotify"
        
        view.addSubview(backgroundImageView)
        view.addSubview(ovarlayView)
        
        view.addSubview(label)
        view.addSubview(logoImageView)
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.frame = CGRect(
            x: (view.width - 120) / 2,
            y: (view.height - 350) / 2,
            width: 120,
            height: 120)
        label.frame = CGRect(
            x: 30,
            y: logoImageView.bottom + 30,
            width: view.width - 60,
            height: 150)
        button.frame = CGRect(
            x: 20,
            y: view.height - 80 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50)
        backgroundImageView.frame = view.bounds
        ovarlayView.frame = view.bounds
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Sth went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}
