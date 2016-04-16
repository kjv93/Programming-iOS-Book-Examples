import UIKit

class ViewController : UIViewController {
    @IBOutlet var v : UIView!
    var pOrig : CGPoint!
    
    func animate() {
        self.pOrig = self.v.center
        let opts : UIViewAnimationOptions = [.autoreverse, .repeat]
        UIView.animate(withDuration:1, delay: 0, options: opts,
            animations: {
                self.v.center.x += 100
            }, completion: nil)
    }
    
    
    func cancel() {
        // this works the same way in iOS 8 as before...
        // ...because animation is not additive when existing animation is repeating
        UIView.animate(withDuration:0.1, delay:0,
            options:.beginFromCurrentState,
            animations: {
                self.v.center = self.pOrig
            }, completion:nil)
    }
    
    @IBAction func doStart(_ sender:AnyObject?) {
        self.animate()
    }
    
    @IBAction func doStop(_ sender:AnyObject?) {
        self.cancel()
    }
    
    
}
