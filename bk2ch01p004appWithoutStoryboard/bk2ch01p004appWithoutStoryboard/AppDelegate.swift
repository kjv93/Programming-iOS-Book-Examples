

import UIKit

import UIKit
@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)
        -> Bool {
            self.window = UIWindow()
            self.window!.rootViewController = UIViewController()
            self.window!.backgroundColor = UIColor.white()
            self.window!.backgroundColor = UIColor.red() // prove it works
            self.window!.makeKeyAndVisible()
            return true
    }
}
