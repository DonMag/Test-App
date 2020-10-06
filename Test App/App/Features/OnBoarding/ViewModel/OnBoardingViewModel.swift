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
        
		// for testing variable number of pages
		let page_5 = Page(id: 4,
						  title: "ONBOARDING.05.TITLE".localized,
						  color: .yellow,
						  image: #imageLiteral(resourceName: "Info"),
						  description: "ONBOARDING.05.DESCRIPTION".localized)
		
		let page_6 = Page(id: 5,
						  title: "ONBOARDING.06.TITLE".localized,
						  color: .green,
						  image: #imageLiteral(resourceName: "Info"),
						  description: "ONBOARDING.06.DESCRIPTION".localized)
		
		let page_7 = Page(id: 6,
						  title: "ONBOARDING.07.TITLE".localized,
						  color: .cyan,
						  image: #imageLiteral(resourceName: "Info"),
						  description: "ONBOARDING.07.DESCRIPTION".localized)

		// to test 7 pages
		//return [page_1, page_2, page_3, page_4, page_5, page_6, page_7]
		
		return [page_1, page_2, page_3, page_4]

    }()
}
