//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import Foundation

public extension String {
    static let empty: String = ""
    
    var localized: String {
        return NSLocalizedString(self, comment: .empty)
    }
    
    func localizedWithFormat(args: CVarArg...) -> String {
      return String(format: localized,
                    locale: NSLocale.current,
                    arguments: args)
    }
}
