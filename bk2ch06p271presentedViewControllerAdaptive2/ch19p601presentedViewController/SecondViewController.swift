

import UIKit

/* 

Standard architecture for handing info from vc to presented vc...
...and back when presented vc is dismissed

*/

protocol SecondViewControllerDelegate : class {
    func accept(data:AnyObject!)
}

class SecondViewController : UIViewController {
    
    var data : AnyObject?
    
    weak var delegate : SecondViewControllerDelegate?
    
    @IBAction func doDismiss(_ sender:AnyObject?) {
        self.presenting!.dismiss(animated:true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self.view.bounds.size.width, terminator: "")
        print("\t", terminator: "")
        print(self.view.bounds.size.height, terminator: "")
        print("\t", terminator: "")

        print(self.view.backgroundColor!)


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed() {
            self.delegate?.accept(data:"Even more important data!")
        }
    }
    
    
}
