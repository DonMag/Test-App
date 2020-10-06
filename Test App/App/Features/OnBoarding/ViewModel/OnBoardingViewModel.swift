//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import Foundation

protocol OnBoardingViewModelType {

}

class OnBoardingViewModel: OnBoardingViewModelType {

    var nextText: String {
        return "ONBOARDING.NEXT.BUTTON".localized
    }

    lazy var pages: [Page] = {

        let page_1 = Page(id: 0,
                          title: "ONBOARDING.01.TITLE".localized,
                          color: .blue,
                          image: #imageLiteral(resourceName: "Info"),
                          description: "ONBOARDING.01.DESCRIPTION".localized)
        
        let page_2 = Page(id: 1,
                          title: "ONBOARDING.02.TITLE".localized,
                          color: .white,
                          image: #imageLiteral(resourceName: "Info"),
                          description: "ONBOARDING.02.DESCRIPTION".localized)
        
        let page_3 = Page(id: 2,
                          title: "ONBOARDING.03.TITLE".localized,
                          color: .white,
                          image: #imageLiteral(resourceName: "Info"),
                          description: "ONBOARDING.03.DESCRIPTION".localized)
        
        let page_4 = Page(id: 3,
                          title: "ONBOARDING.04.TITLE".localized,
                          color: .white,
                          image: #imageLiteral(resourceName: "Info"),
                          description: "ONBOARDING.04.DESCRIPTION".localized)
        
        return [page_1, page_2, page_3, page_4]
    }()
}
