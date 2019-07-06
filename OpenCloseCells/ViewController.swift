//
//  ViewController.swift
//  OpenCloseCells
//
//  Created by Fitsyu  on 06/07/19.
//  Copyright © 2019 Fitsyu . All rights reserved.
//

import UIKit

// Data
struct Model {

    var sizes: (closed: Float, opened: Float)
}

// View
class ModelCell: UITableViewCell {
    
    static let ID = "ModelCell"
}


// Static Data Store
class Store {
    static let data: [Model] = (1...10).map { _ in Model(sizes: (closed: 60, opened: 100)) }
}



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
     }

    var models = Store.data
    

    lazy var openRows: [Int:Bool] = {
        var dict: [Int:Bool] = [:]
        (0..<models.count).forEach {
            dict[$0] = false
        }
        return dict
    }()
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ModelCell.ID, for: indexPath)
        return cell
    }
    
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let state = openRows[indexPath.row] {
            openRows[indexPath.row] = !state
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model: Model = models[indexPath.row]
        let height = openRows[indexPath.row] == true ? model.sizes.opened : model.sizes.closed
        return CGFloat(height)
    }
}



