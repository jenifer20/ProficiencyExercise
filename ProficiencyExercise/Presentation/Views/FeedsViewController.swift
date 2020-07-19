//
//  FeedsViewController.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import UIKit
import CoreData

class FeedsViewController: UIViewController {
    
    var currentDeviceOrientation: UIDeviceOrientation = .unknown
    fileprivate let infoCellReuseIdentifier = "infoTableViewCellIdentifier"
    var feeds : [GetInfoResponse]?
    fileprivate let imageHandler = ImageHandler()
    fileprivate let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        getInfoApi()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate), name: UIDevice.orientationDidChangeNotification, object: nil)
        self.currentDeviceOrientation = UIDevice.current.orientation
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        if UIDevice.current.isGeneratingDeviceOrientationNotifications {
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
    }
    
    @objc func deviceDidRotate(notification: NSNotification) {
        self.currentDeviceOrientation = UIDevice.current.orientation
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        let animationHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            // This block will be called several times during rotation,
            // so if you want your tableView change more smooth reload it here too.
            self?.tableview.reloadData()
        }
        
        let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            // This block will be called when rotation will be completed
            self?.tableview.reloadData()
        }
        
        coordinator.animate(alongsideTransition: animationHandler, completion: completionHandler)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func getInfoApi() {
        
        let request = GetInfoService()
        request.getInfoApi { (error, title, response) in
            
            self.feeds = response as? [GetInfoResponse]
            print(self.feeds?.count ?? 0)
            self.feeds = self.feeds?.filter{$0.title != nil}
            print(self.feeds?.count ?? 0)
            
            DispatchQueue.main.async {
                self.title = title
                self.tableview.dataSource = self
                self.tableview.reloadData()
            }
        }
    }
    
    func configureTableView() {
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(InfoTableViewCell.self, forCellReuseIdentifier: infoCellReuseIdentifier)
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension FeedsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: infoCellReuseIdentifier, for: indexPath) as! InfoTableViewCell
        let details = feeds![(indexPath as NSIndexPath).row]
        
        if let title = details.title {
            cell.nameLabel.text = title
        }
        
        if let description = details.summary {
            cell.descriptionLabel.text = description
        }
        
        cell.feedImageView.tag = indexPath.row
        guard let imageUrl = details.imageHref else {
            return cell
        }
        
        self.imageHandler.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: imageUrl, atIndexPath: indexPath)
        
        //        cell.contentView.setNeedsLayout()
        //        cell.contentView.layoutIfNeeded()
        
        return cell
    }
}

extension FeedsViewController {
    
    func saveFeedsIntoDB(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Feeds", in: context)
        
        //        for feed in feeds! {
        //
        //            if let title = feed.title as? String {
        //
        //            }
        //
        //            if let description = feed.description as? String {
        //
        //            }
        //
        //            if let
        //        }
        
    }
}

