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
        lists = TaskList.getTaskLists()
        title = "ToDoLists"
        createLayout()
        createDataSource()
        createSnapshot()
        navigationItem.leftBarButtonItem = editButtonItem
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
            let delete = UIContextualAction(style: .normal, title: "Delete") {
               [weak self] _, _, completion in
                guard let self = self else { return }
                debugPrint(self.lists)
                completion(true)
            }
            var content = cell.defaultContentConfiguration()
            content.text = taskList.name
            content.image = UIImage(systemName: "list.number")
            cell.contentConfiguration = content
//            let options = UICellAccessory.ReorderOptions(isHidden: false, reservedLayoutWidth: .actual, tintColor: .black, showsVerticalSeparator: true)
//            cell.accessories = [.reorder(displayed: .whenEditing, options: options)]
  
        }
        
        dataSource = UICollectionViewDiffableDataSource<Sections,TaskList>(collectionView: collectionView, cellProvider: { collectionView, indexPath, taskList in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: taskList)
        })
    }
    
    private func createLayout() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        configuration.leadingSwipeActionsConfigurationProvider =  { [weak self] (indexPath) in
//            guard let self = self else { return nil }
//            guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
            let delete = UIContextualAction(style: .normal, title: "DELETE") { _, _, completion in
                print("OK")
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }
        
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

