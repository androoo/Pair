//
//  PairTableViewController.swift
//  Pair
//
//  Created by Andrew Ervin Gierke on 3/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit

class PairTableViewController: UITableViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var randomButton: UIButton!
    
    
    //MARK: - UI Actions
    
    @IBAction func addPersonButtonTapped(_ sender: Any) {
        addPerson()
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        PersonController.shared.randomize()
        tableView.reloadData()
    }
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pairs"
        randomButtonAppearance()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if PersonController.shared.persons.count % 2 == 0 {
            return PersonController.shared.persons.count / 2
        } else {
            return (PersonController.shared.persons.count + 1) / 2
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.pairs[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \([section + 1][0])"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let personCell = PersonController.shared.pairs[indexPath.section][indexPath.row]
        cell.textLabel?.text = personCell.name
        
        return cell
    }
    
    //MARK: - Helper Methods
    
    func addPerson() {
        let alertController = UIAlertController(title: "Add Someone", message: nil, preferredStyle: .alert)
        var personNameTextField: UITextField?
        
        alertController.addTextField { (textfield) in
            personNameTextField = textfield
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = personNameTextField?.text else { return }
            PersonController.shared.addPersonNamed(name: name)
            PersonController.shared.persons = PersonController.shared.people
            PersonController.shared.persons.random()
            self.tableView.reloadData()
        }
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true , completion: nil)
    }
    
    func randomButtonAppearance() {
        randomButton.backgroundColor = .clear
        randomButton.layer.borderWidth = 2
        randomButton.layer.borderColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5).cgColor
    }
}
