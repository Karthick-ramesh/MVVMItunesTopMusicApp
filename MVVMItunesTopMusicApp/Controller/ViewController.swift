//
//  ViewController.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 28/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var topMusicTableView: UITableView!
    let topMusicViewModel = TopMusicViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topMusicTableView.dataSource = self
        topMusicViewModel.getTopMusic(page: 10) {[weak self] (musicItems, error) in
            DispatchQueue.main.async {
                self?.topMusicTableView.reloadData()
            }
        }
    }
}

//MARK:- Tableview Data Source

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topMusicViewModel.topMusicItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIdentifer.topMusicCellIdentifer.rawValue, for: indexPath) as! TopMusicTableViewCell
        let currentMusicItemViewModel = topMusicViewModel.topMusicItems![indexPath.row]
        cell.config(viewModelPresentable: currentMusicItemViewModel as! TopMusicItemViewModel)
        return cell
    }
}

