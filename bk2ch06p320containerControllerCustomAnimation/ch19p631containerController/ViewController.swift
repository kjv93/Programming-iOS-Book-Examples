
import UIKit

class ViewController : UIViewController {
    
    @IBOutlet var panel : UIView!
    var cur : Int = 0
    var swappers = [UIViewController]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // still assuming that this trick will work
        self.swappers += [FirstViewController()]
        self.swappers += [SecondViewController()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = self.swappers[cur]
        self.addChildViewController(vc) // "will" called for us
        vc.view.frame = self.panel.bounds
        self.panel.addSubview(vc.view) // insert view into interface between "will" and "did"
        // note: when we call add, we must call "did" afterwards
        vc.didMove(toParentViewController: self)
        
        self.constrainInPanel(vc.view) // *
    }
    
    @IBAction func doFlip(_ sender:AnyObject?) {
        UIApplication.shared().beginIgnoringInteractionEvents()
        let fromvc = self.swappers[cur]
        cur = cur == 0 ? 1 : 0
        let tovc = self.swappers[cur]
        tovc.view.frame = self.panel.bounds

        UIGraphicsBeginImageContextWithOptions(tovc.view.bounds.size, true, 0)
        tovc.view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let im = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let iv = UIImageView(image:im)
        iv.frame = CGRect.zero
        self.panel.addSubview(iv)
        tovc.view.alpha = 0
        
        // must have both as children before we can transition between them
        self.addChildViewController(tovc) // "will" called for us
        // note: when we call remove, we must call "will" (with nil) beforehand
        fromvc.willMove(toParentViewController: nil)
        // then perform the transition
        self.transition(from:fromvc,
            to:tovc,
            duration:0.4,
            options:[], // .transitionNone
            animations: {
                iv.frame = self.panel.bounds // *
                self.constrainInPanel(tovc.view) // *
            },
            completion:{
                _ in
                tovc.view.alpha = 1
                iv.removeFromSuperview()
                // finally, finish up
                // note: when we call add, we must call "did" afterwards
                tovc.didMove(toParentViewController: self)
                fromvc.removeFromParentViewController() // "did" called for us
                UIApplication.shared().endIgnoringInteractionEvents()
            })
    }
    
    func constrainInPanel(_ v:UIView) {
        print("constrain")
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint.constraints(withVisualFormat:"H:|[v]|", options:[], metrics:nil, views:["v":v]),
            NSLayoutConstraint.constraints(withVisualFormat:"V:|[v]|", options:[], metrics:nil, views:["v":v])
            ].flatten().map{$0})
    }
    
}