//
//  Extensions.swift
//  ModernToDoList
//
//  Created by Евгений Березенцев on 02.08.2021.
//

import UIKit

extension TaskListCollectionViewController: TaskCollectionViewControllerDelegate {
    
    func updateList(with tasks: [Task]) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        lists[indexPath.item].tasks = tasks
        createSnapshot()
    }
    
    @objc func addNewList() {
        let alertController = UIAlertController(title: "Введите название", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Добавить список"
            textField.returnKeyType = .done
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Добавить", style: .default) {[weak self] _ in
            guard let self = self else { return }
            guard let TF = alertController.textFields?.first else {return}
            guard let name = TF.text, !name.isEmpty else {return}
            self.lists.append(TaskList(name: name, tasks: []))
            self.createSnapshot()
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    enum Sections {
        case main
    }
}

extension TaskCollectionViewController {
    @objc func addNewTask() {
        let alertController = UIAlertController(title: "Введите название", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Добавить таск"
            textField.returnKeyType = .done
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Добавить", style: .default) {[weak self] _ in
            guard let self = self else { return }
            guard let TF = alertController.textFields?.first else {return}
            guard let name = TF.text, !name.isEmpty else {return}
            self.tasks?.append(Task(name: name, isDone: false))
            self.createSnapshot()
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    enum Sections {
        case main
    }
}
