

import UIKit

// both objects must derive from NSObject

class MyClass1 : NSObject {
    // absolutely crucial to say "dynamic" or this won't work
    dynamic var value : Bool = false
}

class MyClass2: NSObject {
    
    override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
            print("I heard about the change!")
            if let keyPath = keyPath {
                print(object?.value?(forKeyPath:keyPath))
            }
            print(change)
            print(context == &con) // aha
            let c = UnsafeMutablePointer<String>(context)
            if let s = c?.pointee {
                print(s)
            }
        }
    
}

private var con = "ObserveValue"

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var objectA : NSObject!
    var objectB : NSObject!
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]? = [:]) -> Bool {
    
        self.window = UIWindow()
        self.window!.rootViewController = UIViewController()
        self.window!.backgroundColor = UIColor.white()
        self.window!.makeKeyAndVisible()
        
        
        objectA = MyClass1()
        objectB = MyClass2()
        let opts : NSKeyValueObservingOptions = [.new, .old]
        objectA.addObserver(objectB, forKeyPath: "value", options: opts, context: &con)
        (objectA as! MyClass1).value = true
        // comment out next line if you wish to crash
        objectA.removeObserver(objectB, forKeyPath: "value")
        objectA = nil
        
        return true
    }
}
