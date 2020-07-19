//
//  ImageHandler.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import UIKit

protocol ImageHandlerProtocol {
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath)
}

class ImageHandler: ImageHandlerProtocol {
    fileprivate let kLazyLoadCellImageViewTag = 1
    fileprivate let kLazyLoadPlaceholderImage = UIImage(named: "no-image-placeholder.jpg")!
    var imageDownloader: ImageDownloader { return ImageDownloader() }

    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath) {
        
        let imageView = cell.viewWithTag(indexPath.row) as? UIImageView
        imageView?.image = kLazyLoadPlaceholderImage
        imageDownloader.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView?.image = image
                }
            }
        }
    }
}
