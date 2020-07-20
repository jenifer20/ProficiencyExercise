//
//  StoredImagesModel.swift
//  ProficiencyExercise
//
//  Created by Jeni on 20/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

struct StoredImagesModel {
    let imageBinaryData: Data
    let imageUrlString: String
    
    init(images: StoreImages) {
        imageBinaryData = images.imageBinaryData
        imageUrlString = String.emptyIfNil(images.imageUrlString)
    }
}

extension StoredImagesModel: Equatable {}

func ==(lhs: StoredImagesModel, rhs: StoredImagesModel) -> Bool {
    return lhs.imageBinaryData == rhs.imageBinaryData &&
        lhs.imageUrlString == rhs.imageUrlString
}
