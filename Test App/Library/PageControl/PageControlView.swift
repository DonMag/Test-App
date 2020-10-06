//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import UIKit
import Foundation

public class PageControlView: UIView {
    
    public var pageIndex: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var color: UIColor = .white {
        didSet {
            drawer.color = color
            setNeedsDisplay()
        }
    }
    
    public var numberOfPages: Int {
        get { return drawer.numberOfPages }
        set (val) { drawer.numberOfPages = val }
    }
    
    public var drawer: AdvancedPageControlDraw = ExtendedDotDrawer()
    
    public func setCurrentItem(index: CGFloat) {
        self.drawer.currentItem = index
        setNeedsDisplay()
    }
    
    public func setCurrentItem(offset:CGFloat, width:CGFloat) {
        self.drawer.currentItem = CGFloat(offset) / CGFloat(width)
        setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        drawer.draw(rect)
    }
}
