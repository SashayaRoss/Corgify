//
//  LibraryPlaylistsViewController.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 01/04/2023.
//

import UIKit

final class LibraryPlaylistsViewController: UIViewController {
    var playlists = [Playlist]()
    
    var selectionHandler: ((Playlist) -> Void)?
    
    private let noPlaylistsView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(
            SearchResultsSubtitleTableViewCell.self, // rename cell
            forCellReuseIdentifier: SearchResultsSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupNoPlaylistsView()
        fetchData()
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
        tableView.frame = view.bounds
    }
    
    private func setupNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(with: ActionLabelViewViewModel(
            text: "You don't have any playlists yet!",
            actionTitle: "Create"))
    }
    
    private func fetchData() {
        ApiCaller.shared.getCurrentUserPlaylist() { [weak self] results in
            DispatchQueue.main.async {
                switch results {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription) //
                }
            }
        }
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            //show label
            noPlaylistsView.isHidden = false
            tableView.isHidden = true
        } else {
            // show table
            tableView.reloadData()
            tableView.isHidden = false
            noPlaylistsView.isHidden = true
        }
    }
    
    public func showCreatePlaylistAlert()  {
        let alert = UIAlertController(
            title: "New Playlist",
            message: "Enter playlist name",
            preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Playlist..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                      return
                  }
            ApiCaller.shared.createPlaylist(with: text) { success in
                if success {
                    // refresh
//                    self.updateUI()
                } else {
                    // error
                    print("Failed to create a playlist")
                }
                
            }
        }))
        
        present(alert, animated: true)
    }
}

extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // show creation ui for playlist
        showCreatePlaylistAlert()
    }
}

extension LibraryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultsSubtitleTableViewCell.identifier,
            for: indexPath) as? SearchResultsSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultsSubtitleTableViewCellViewModel(
            title: playlist.name,
            subtitle: playlist.owner.display_name,
            imageURL: URL(string: playlist.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playlist = playlists[indexPath.row]
        guard selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true)
            return
        }
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
