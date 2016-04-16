

import UIKit

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}


@UIApplicationMain class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    let which = 6

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
            
            v1.transform = CGAffineTransform(rotationAngle:45 * CGFloat(M_PI)/180.0)
            print(v1.frame)
            
        case 2:
            let v1 = UIView(frame:CGRect(113, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds.insetBy(dx: 10, dy: 10))
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)
            
            v1.transform = CGAffineTransform(scaleX:1.8, y:1)
            
        case 3:
            let v1 = UIView(frame:CGRect(20, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds)
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)
            
            v2.transform = CGAffineTransform(translationX:100, y:0)
            v2.transform = v2.transform.rotate(45 * CGFloat(M_PI)/180.0)
            
        case 4:
            let v1 = UIView(frame:CGRect(20, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds)
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)
            
            v2.transform = CGAffineTransform(rotationAngle:45 * CGFloat(M_PI)/180.0)
            v2.transform = v2.transform.translateBy(x: 100, y: 0)
            
        case 5: // same as case 4 but using concat
            let v1 = UIView(frame:CGRect(20, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds)
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)
            
            let r = CGAffineTransform(rotationAngle:45 * CGFloat(M_PI)/180.0)
            let t = CGAffineTransform(translationX:100, y:0)
            v2.transform = t.concat(r) // not r.concat(t)
            
        case 6:
            let v1 = UIView(frame:CGRect(20, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds)
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)

            let r = CGAffineTransform(rotationAngle:45 * CGFloat(M_PI)/180.0)
            let t = CGAffineTransform(translationX:100, y:0)
            v2.transform = t.concat(r)
            v2.transform = r.invert().concat(v2.transform)
            
        case 7:
            let v1 = UIView(frame:CGRect(113, 111, 132, 194))
            v1.backgroundColor = UIColor(red: 1 as CGFloat, green: 0.4, blue: 1, alpha: 1)
            let v2 = UIView(frame:v1.bounds.insetBy(dx: 10, dy: 10))
            v2.backgroundColor = UIColor(red: 0.5 as CGFloat, green: 1, blue: 0, alpha: 1)
            mainview.addSubview(v1)
            v1.addSubview(v2)

            v1.transform = CGAffineTransform(a:1, b:0, c:-0.2, d:1, tx:0, ty:0)
            
        default: break
        }
        
        
        
        self.window!.backgroundColor = UIColor.white()
        self.window!.makeKeyAndVisible()
        return true
    }
    
}
