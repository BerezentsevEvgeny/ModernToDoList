//
//  TaskCollectionViewController.swift
//  ModernToDoList
//
//  Created by Евгений Березенцев on 01.08.2021.
//

import UIKit

class TaskCollectionViewController: UICollectionViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections,Task>!
    var delegate: TaskCollectionViewControllerDelegate!
    var tasks: [Task]?

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        createDataSource()
        createSnapshot()
        navigationItem.rightBarButtonItem = .some(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask)))

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let tasks = tasks else { return }
        delegate.updateList(with: tasks)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    // MARK: UICollectionViewDataSource
    
    private func createDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell,Task> { cell, indexPath, task in
            var content = cell.defaultContentConfiguration()
            content.text = task.name
            if task.isDone {
                content.image = UIImage(systemName: "checkmark.circle")
            } else {
                content.image = UIImage(systemName: "minus.circle")
            }
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Sections,Task>(collectionView: collectionView, cellProvider: { collectionView, indexPath, task in
            collectionView.dequeueConfiguredReusableCell(
                using: registration, for: indexPath, item: task)
        })
    }
    
    private func createLayout() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections,Task>()
        snapshot.appendSections([.main])
        guard let tasks = tasks else { return }
        snapshot.appendItems(tasks)
        dataSource.apply(snapshot)
    }

}


