//
//  ResultViewController.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/19/20.
//

import UIKit

protocol ResultViewControllerDelegate: class {
    func resultViewController(_ vc: UIViewController, selected venue: Venue)
}

class ResultViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var resultTableView: UITableView!
    
    //MARK:- Properties
    private var searchController: UISearchController!
    weak var delegate: ResultViewControllerDelegate?
    var venues = [Venue]()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupResultTableView()
    }
    
    //MARK:- Configure UI
    private func setupResultTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.estimatedRowHeight = 100
        resultTableView.rowHeight = UITableView.automaticDimension
        resultTableView.register(UINib(nibName: ResultCell.nibName, bundle: nil), forCellReuseIdentifier: ResultCell.reuseIdentifier)
    }
    
    private func addFooterView() -> UILabel {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.resultTableView.bounds.size.width, height: self.resultTableView.bounds.size.height))
        noDataLabel.text          = "No data available"
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        return noDataLabel
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if venues.isEmpty {
            resultTableView.backgroundView  = addFooterView()
            resultTableView.separatorStyle  = .none
        }
        else {
            resultTableView.separatorStyle = .singleLine
            resultTableView.backgroundView = nil
        }
        
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let resultModel = ResultCellViewModel(venue: venues[indexPath.row])
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier, for: indexPath) as! ResultCell
        cell.resultViewModel = resultModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.resultViewController(self, selected: venues[indexPath.row])
    }
}

