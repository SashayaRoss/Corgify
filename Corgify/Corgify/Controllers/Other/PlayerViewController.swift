//
//  PlayerViewController.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//

import UIKit

final class PlayerViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controllsView = PlayerControllsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controllsView)
        configureBarButtons()
        
        controllsView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width)
        controllsView.frame = CGRect(
            x: 10,
            y: imageView.bottom + 10,
            width: view.width - 20,
            height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15)
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction() {
        //
    }
}

extension PlayerViewController: PlayerControllsViewDelegate {
    func playerControllsViewDidTapPlayPauseButton(_ playersControllView: PlayerControllsView) {
        //
    }
    
    func playerControllsViewDidTapForwardButton(_ playersControllView: PlayerControllsView) {
        //
    }
    
    func playerControllsViewDidTapPlayBackButton(_ playersControllView: PlayerControllsView) {
        //
    }
}
