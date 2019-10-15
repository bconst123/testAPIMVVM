//
//  MainViewController.swift
//  secondAttemptTest
//
//  Created by Bruno Augusto Constantino on 9/30/19.
//  Copyright © 2019 Bruno Augusto Constantino. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let apiManager = APIManager()
    private var arrayShort = [String]()
    
    @IBOutlet weak var inputedUrl: UITextField!

    @IBOutlet weak var tableViewAlias: UITableView!
    
    @IBAction func getAlias(_ sender: Any) {
        guard let aliasValue = self.inputedUrl.text else {return}
        if aliasValue != "" {
            apiManager.getAliasURL(aliasValue) {(resultData, error) in
                if let error = error {
                    print("ERROR: \(error)")
                    return
                }
                guard let responseData = resultData else {return}
                self.resultValue = responseData
                if let value = self.linkViewModel?.short {
                    if !self.arrayShort.contains(value){
                        self.arrayShort.append(value)
                    }
                }
                DispatchQueue.main.async {
                    self.tableViewAlias.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewAlias.reloadData()
    }
    
    private(set) var linkViewModel: UrlAliasViewModel?
    var resultValue: LinkAliasType? {
        didSet {
            guard let resultVal = resultValue else {return}
            linkViewModel = UrlAliasViewModel.init(link: resultVal._links.`self`, alias: resultVal.alias, short: resultVal._links.short )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayShort.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)
        
        cell.textLabel?.text = arrayShort[indexPath.item]
        
        return cell
    }
    
}
