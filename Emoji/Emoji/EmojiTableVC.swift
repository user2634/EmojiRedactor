//
//  EmojiTableVC.swift
//  Emoji
//
//  Created by Dava on 04.11.2020.
//

import UIKit

class EmojiTableVC: UITableViewController {
    var emojiArr = [
        Emoji(title: "❤️", name: "Love", description: "I love you"),
        Emoji(title: "😤", name: "Angry", description: "Dont touch me"),
        Emoji(title: "😎", name: "Cool", description: "Im cool")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindToMainVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "saveSegue" else {return}
        let sourceVC = unwindSegue.source as! SecondEmojiVC
        let obj = sourceVC.obj
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            emojiArr[selectedIndexPath.row] = obj
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        }else{
            let newIndexPath = IndexPath(row: emojiArr.count, section: 0)
            emojiArr.append(obj)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editCell" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let obj = emojiArr[indexPath.row]
        let navVC = segue.destination as! UINavigationController
        let secondVC = navVC.topViewController as! SecondEmojiVC
        secondVC.obj = obj
        secondVC.title = "Edit"
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojiArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! EmojiCell
        let obj = emojiArr[indexPath.row]
        cell.titleLable.text = obj.title
        cell.nameLable.text = obj.name
        cell.descriptionLable.text = obj.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            emojiArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojiArr.remove(at: sourceIndexPath.row)
        emojiArr.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = deleteAction(at: indexPath)
        let action2 = isFavorite(at: indexPath)
        return UISwipeActionsConfiguration(actions: [action1,action2])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "delete", handler: { (action, view, completion) in
            self.emojiArr.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        })
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "trash.circle")
        return action
    }
    
    func isFavorite(at indexPath: IndexPath) -> UIContextualAction{
        var object = emojiArr[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "like") { (action, view, completion) in
            object.like = !object.like
            self.emojiArr[indexPath.row] = object
            completion(true)
        }
        action.image = UIImage(systemName: "suit.heart")
        action.backgroundColor = object.like ? .systemGreen : .systemGray
        return action
    }
}
