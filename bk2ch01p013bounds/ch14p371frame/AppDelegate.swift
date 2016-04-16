import UIKit

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}


@UIApplicationMain class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    let which = 1

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow()
        
        self.window!.rootViewController = UIViewController()
        let mainview = self.window!.rootViewController!.view
        
        switch which {
        case 1:
            let v1 = UIView(frame:CGRect(113, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds.insetBy(dx: 10, dy: 10))
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)
            
        case 2:
            let v1 = UIView(frame:CGRect(113, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds.insetBy(dx: 10, dy: 10))
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)

            v2.bounds.size.height += 20
            v2.bounds.size.width += 20
            
        case 3:
            let v1 = UIView(frame:CGRect(113, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds.insetBy(dx: 10, dy: 10))
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)
            
            v1.bounds.origin.x += 10
            v1.bounds.origin.y += 10

        default: break
        }
        
        
        
        self.window!.backgroundColor = UIColor.white()
        self.window!.makeKeyAndVisible()
        return true
    }
    
}
