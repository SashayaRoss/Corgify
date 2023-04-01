//
//  PlayerViewController.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 03/02/2023.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

final class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controllsView = PlayerControllsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controllsView)

        controllsView.delegate = self
        
        configureBarButtons()
        configure()
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
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL)
        controllsView.configure(with: PlayerControlsViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle))
    }
    
    func refreshUI() {
        configure()
    }
}

extension PlayerViewController: PlayerControllsViewDelegate {
    func playerControllsView(_ playersControllView: PlayerControllsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func playerControllsViewDidTapPlayPauseButton(_ playersControllView: PlayerControllsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControllsViewDidTapForwardButton(_ playersControllView: PlayerControllsView) {
        delegate?.didTapForward()
    }
    
    func playerControllsViewDidTapPlayBackButton(_ playersControllView: PlayerControllsView) {
        delegate?.didTapBackward()
    }
}
