//
//  SecondEmojiVC.swift
//  Emoji
//
//  Created by Dava on 05.11.2020.
//

import UIKit

class SecondEmojiVC: UITableViewController {
    var obj = Emoji(title: "", name: "", description: "")
    @IBOutlet weak var titileTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButton()
        updateUI()
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveSegue" else {return}
        let title = titileTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        obj = Emoji(title: title, name: name, description: description)
    }
    @IBAction func textEdit(_ sender: Any) {
       updateSaveButton()
    }
    
   private func updateSaveButton(){
        let titileText = titileTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descriptionText = descriptionTF.text ?? ""
        saveButton.isEnabled = !titileText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    private func updateUI(){
        titileTF.text = obj.title
        nameTF.text = obj.name
        descriptionTF.text = obj.description
    }
}
