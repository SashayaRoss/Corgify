//
//  SearchResultsViewController.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 24/03/2023.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResults(_ result: SearchResult)
}

final class SearchResultsViewController: UIViewController {
    
    private var sections: [SearchSection] = []
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(
            SearchResultsDefaultTableViewCell.self,
            forCellReuseIdentifier: SearchResultsDefaultTableViewCell.identifier)
        tableView.register(
            SearchResultsSubtitleTableViewCell.self,
            forCellReuseIdentifier: SearchResultsSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })
        let albums = results.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })
        let tracks = results.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })
        let playlists = results.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Albums", results: albums),
        ]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        switch result {
        case .artist(model: let artist):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsDefaultTableViewCell.identifier,
                for: indexPath) as? SearchResultsDefaultTableViewCell else {
                    return UITableViewCell()
                }
            cell.configure(with: SearchResultsDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL: URL(string: artist.images?.first?.url ?? "")))
            return cell
        case .album(model: let album):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsSubtitleTableViewCell.identifier,
                for: indexPath) as? SearchResultsSubtitleTableViewCell else {
                    return UITableViewCell()
                }
            cell.configure(with: SearchResultsSubtitleTableViewCellViewModel(
                title: album.name,
                subtitle: album.artists.first?.name ?? "",
                imageURL: URL(string: album.images.first?.url ?? "")))
            return cell
        case .playlist(model: let playlist):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsSubtitleTableViewCell.identifier,
                for: indexPath) as? SearchResultsSubtitleTableViewCell else {
                    return UITableViewCell()
                }
            cell.configure(with: SearchResultsSubtitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.owner.display_name,
                imageURL: URL(string: playlist.images.first?.url ?? "")))
            return cell
        case .track(model: let track):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsSubtitleTableViewCell.identifier,
                for: indexPath) as? SearchResultsSubtitleTableViewCell else {
                    return UITableViewCell()
                }
            cell.configure(with: SearchResultsSubtitleTableViewCellViewModel(
                title: track.name,
                subtitle: track.artists.first?.name ?? "",
                imageURL: URL(string: track.album?.images.first?.url ?? "")))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResults(result)
    }
}
