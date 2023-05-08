//
//  ViewController.swift
//  myMemos
//
//  Created by Александра Кострова on 02.05.2023.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    private var myTableView: UITableView!
    private var myCellsArray = ["First", "Second", "Third", "Fourth", "Fifth"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let statusBarHeight = windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let barHeight = statusBarHeight + (self.navigationController?.navigationBar.frame.height ?? 0)
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0,
                                                y: barHeight,
                                                width: displayWidth,
                                                height: displayHeight - barHeight))
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: Keys.cellIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier, for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myCellsArray[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCellsArray.count
    }
}
