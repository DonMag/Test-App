//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import UIKit
import Foundation

public typealias OnBoardingPageCompletion = ((_ success: Bool, _ error: Error?) -> Void)

public struct Page {
    var id: Int = 0
    let title: String
    let image: UIImage?
    let description: String?
    let nexteButtonTitle: String?
    let actionButtonTitle: String?
    let color: UIColor?
    
    public init(id: Int,
                title: String,
                color: UIColor? = .red,
                image: UIImage? = nil,
                description: String?,
                nextButtonTitle: String? = nil,
                actionButtonTitle: String? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.image = image
        self.description = description
        self.nexteButtonTitle = nextButtonTitle
        self.actionButtonTitle = actionButtonTitle
    }
}
