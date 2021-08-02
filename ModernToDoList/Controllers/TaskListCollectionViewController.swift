//
//  TaskListCollectionViewController.swift
//  ModernToDoList
//
//  Created by Евгений Березенцев on 01.08.2021.
//

import UIKit

protocol TaskCollectionViewControllerDelegate {
    func updateList(with tasks: [Task])
}

class TaskListCollectionViewController: UICollectionViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections,TaskList>!
    var lists: [TaskList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        lists = DataManager.shared.taskLists
        title = "ToDoLists"
        createLayout()
        createDataSource()
        createSnapshot()
        navigationItem.rightBarButtonItem = .some(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewList)))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let taskListToEdit = dataSource.itemIdentifier(for: indexPath) else { return }
        let taskVC = TaskCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        taskVC.tasks = taskListToEdit.tasks
        taskVC.delegate = self
        taskVC.title = taskListToEdit.name + " tasks"
        navigationController?.pushViewController(taskVC, animated: true)
    }

    // MARK: - UICollectionViewDataSource
    
    private func createDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell,TaskList> { cell, indexPath, taskList in
            var content = cell.defaultContentConfiguration()
            content.text = taskList.name
            content.image = UIImage(systemName: "list.number")
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Sections,TaskList>(collectionView: collectionView, cellProvider: { collectionView, indexPath, taskList in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: taskList)
        })
    }
    
    private func createLayout() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections,TaskList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(lists)
        dataSource.apply(snapshot)
    }
    
}

