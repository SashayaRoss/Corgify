//
//  LibraryAlbumsViewController.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 01/04/2023.
//

import UIKit

final class LibraryAlbumsViewController: UIViewController {
    var albums = [Album]()
    
    private let noAlbumView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(
            SearchResultsSubtitleTableViewCell.self, // rename cell
            forCellReuseIdentifier: SearchResultsSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupNoAlbumsView()
        fetchData()
        observer = NotificationCenter.default.addObserver(
            forName: .albumSavedNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.fetchData()
            })
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumView.frame = CGRect(x: (view.width - 150) / 2, y: (view.height - 150) / 2, width: 150, height: 150)
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    private func setupNoAlbumsView() {
        view.addSubview(noAlbumView)
        noAlbumView.delegate = self
        noAlbumView.configure(with: ActionLabelViewViewModel(
            text: "You have not saved any albums yet!",
            actionTitle: "Browse"))
    }
    
    private func fetchData() {
        albums.removeAll()
        ApiCaller.shared.getCurrentUserAlbums() { [weak self] results in
            DispatchQueue.main.async {
                switch results {
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription) //
                }
            }
        }
    }
    
    private func updateUI() {
        if albums.isEmpty {
            //show label
            noAlbumView.isHidden = false
            tableView.isHidden = true
        } else {
            // show table
            tableView.reloadData()
            tableView.isHidden = false
            noAlbumView.isHidden = true
        }
    }
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultsSubtitleTableViewCell.identifier,
            for: indexPath) as? SearchResultsSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultsSubtitleTableViewCellViewModel(
            title: album.name,
            subtitle: album.artists.first?.name ?? "~",
            imageURL: URL(string: album.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
