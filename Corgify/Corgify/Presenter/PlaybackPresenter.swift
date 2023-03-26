//
//  PlaybackPresenter.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 26/03/2023.
//

import UIKit

final class PlaybackPresenter {
    static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    // For playlist, album:
    static func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
