//
//  FeedsModel.swift
//  ProficiencyExercise
//
//  Created by Jeni on 20/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

struct FeedsModel {
    let title: String
    let summary: String
    let imageHref: String
    
    init(feeds: Feeds) {
        title = String.emptyIfNil(feeds.title)
        summary = String.emptyIfNil(feeds.summary)
        imageHref = String.emptyIfNil(feeds.imageHref)
    }
}

extension FeedsModel: Equatable {}

func ==(lhs: FeedsModel, rhs: FeedsModel) -> Bool {
    return lhs.title == rhs.title &&
        lhs.summary == rhs.summary &&
        lhs.imageHref == rhs.imageHref
}
