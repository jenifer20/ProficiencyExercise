//
//  FeedsViewController.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import UIKit
import CoreData

class FeedsViewController: UIViewController, ActivityIndicatorPresenter {
  
    var activityIndicator =  UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    let dataController = DataController()
    
    var feeds: [FeedsModel?]? = []
    var storedImages: [StoredImagesModel?]? = []
    
    var currentDeviceOrientation: UIDeviceOrientation = .unknown
    
    fileprivate let imageHandler = ImageHandler()
    
    fileprivate let tableview = UITableView()
    
    fileprivate let infoCellReuseIdentifier = "infoTableViewCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(getFeedsApi), for: .valueChanged)
        
        // Configuring TableView Programatically
        configureTableView()
        
        // API Service Call
        if Reachability.isConnectedToNetwork() {
            // Showing Activity Indicator
            showActivityIndicator()
            
            getFeedsApi()
        }else {
            getFeedsFromStorage()
            
            self.showToast(message: "You're Offline", font: AppConstants.FontStyle.Font.avenir_medium.font(size: AppConstants.FontStyle.Font.Size.small)!)
        }
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK:- API Service Call
    @objc func getFeedsApi() {

        let request = GetInfoService()
        request.getInfoApi { (success, title) in

            // Stoping Activity Indicator
            self.hideActivityIndicator()
            
            if success {
                // Clearing Images Storage from DB to insert latest images from api response
//                self.dataController.clearImagesStorage()
                DispatchQueue.main.async {
                    self.title = title }
            }
            
            self.getFeedsFromStorage()
        }
    }
    
    func getFeedsFromStorage() {
        
        self.feeds = []
        
        // Fetching Data from CoreData
        if let feedData = self.dataController.fetchFromStorage()
        {
            let newFeeds = self.dataController.initViewModels(feedData)
            self.feeds?.append(contentsOf: newFeeds)
            self.feeds = self.feeds?.filter{$0?.title != ""}
            print("Feeds Count \(String(describing: self.feeds?.count))")
        }
        
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.tableview.dataSource = self
            self.tableview.reloadData()
        }
    }
    
    //MARK:- Configuring TableView
    func configureTableView()
    {
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.tableFooterView = UIView(frame: .zero)
        tableview.register(InfoTableViewCell.self, forCellReuseIdentifier: infoCellReuseIdentifier)
        
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if #available(iOS 10.0, *) {
            tableview.refreshControl = refreshControl
        } else {
            tableview.addSubview(refreshControl)
        }
    }
    
    @objc func loadImagesFromStorage() {
        
        if let imagesStorageData = dataController.fetchImagesFromStorage() {
            let newImages = dataController.initViewModels(imagesStorageData)
            self.storedImages?.append(contentsOf: newImages)
            
//            print("Image URL \(storedImages.map{$0})")
        }
    }
}

extension FeedsViewController : UITableViewDataSource {
    
    //MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: infoCellReuseIdentifier, for: indexPath) as! InfoTableViewCell
        
        let details = feeds![indexPath.row]
        
        cell.nameLabel.text = details?.title
        cell.descriptionLabel.text = details?.summary
        cell.feedImageView.tag = indexPath.row
        
        if details?.imageHref == "" {
            return cell
        }
        
        if let imagesStorageData = dataController.fetchImageDataOf(urlString: details!.imageHref) {
            let newImages = dataController.initViewModels(imagesStorageData)
            self.storedImages?.append(contentsOf: newImages)
                        
            if storedImages!.count == 1 {
                
                let imageDetails = storedImages?[0]
                cell.feedImageView.image = UIImage(data: imageDetails!.imageBinaryData)
            }
            else {
                self.imageHandler.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: details!.imageHref, atIndexPath: indexPath)
            }
        }
        else {
            self.imageHandler.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: details!.imageHref, atIndexPath: indexPath)
        }
        
        
//        cell.contentView.setNeedsLayout()
//        cell.contentView.layoutIfNeeded()
        
        return cell
    }
}

extension FeedsViewController {
    
    //MARK:- Device Orientation Related Methods
    
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


}

