


import UIKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow()
        
        let rvc = RootViewController()
        rvc.restorationIdentifier = "root"
        let nav = UINavigationController(rootViewController:rvc)
        nav.restorationIdentifier = "nav"
        
        self.window!.rootViewController = nav
        self.window!.backgroundColor = UIColor.white()
        self.window!.restorationIdentifier = "window"
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        print("app should restore \(coder)")
        // how to examine the coder
        if let idiomraw = coder.decodeObject(
            forKey: UIApplicationStateRestorationUserInterfaceIdiomKey) as? Int {
                if let idiom = UIUserInterfaceIdiom(rawValue:idiomraw) {
                    if idiom == .phone {
                        print("phone")
                    } else {
                        print("pad")
                    }
                }
        }
        return true
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        print("app should save \(coder)")
        return true
    }
    
    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        print("app will encode \(coder)")
    }
    
    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        print("app did decode \(coder)")
    }
    
    /*
    
    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath ip: [AnyObject], coder: NSCoder) -> UIViewController? {
        
        print("app delegate \(ip) \(coder)")
        let last = ip.last as String
        if last == "nav" {
            return self.window!.rootViewController
        }
        if last == "root" {
            return (self.window!.rootViewController as UINavigationController).viewControllers[0] as? UIViewController
        }
        return nil // shouldn't happen; the others all have restoration classes
    }

*/

    
}
