//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import UIKit
import WWLayout

extension Layout {
    func anchor(to: UIView) {
        self.top(to: to)
            .leading(to: to)
            .trailing(to: to)
            .bottom(to: to)
            .height(to: to)
    }
}

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
    var window: UIWindow?
    weak static var instance: AppDelegate!

    var orientationLock = UIInterfaceOrientationMask.all

    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = OnBoardingViewController()
    
        window?.backgroundColor = .red
        window?.makeKeyAndVisible()
        
    }
    
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        configureWindow()

        return true
    }
    
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor
        window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}
