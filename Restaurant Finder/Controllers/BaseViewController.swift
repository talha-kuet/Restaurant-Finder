//
//  BaseViewController.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showLoadingBlocker() {
        
        if let activityIndicator = activityIndicator {
            activityIndicator.removeFromSuperview()
        }

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.frame = .zero
        activityIndicator?.startAnimating()
        activityIndicator?.layer.zPosition = 10
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator!)
        
        activityIndicator?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator?.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func hideLoadingBlocker() {
        guard let activityIndicator = activityIndicator else {return}
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func showErrorAlert(_ error: Error?) {
        
        let alertController = UIAlertController(title: "Error!!", message: error?.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let rootVC = self.view.window?.rootViewController {
            rootVC.present(alertController, animated: true, completion: nil)
        }
    }
}
