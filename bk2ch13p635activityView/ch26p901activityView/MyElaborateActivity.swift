
import UIKit

class MyElaborateActivity : UIActivity {
    
    var items : [AnyObject]?
    var image : UIImage
    
    override init() {
        let idiom = UIScreen.main().traitCollection.userInterfaceIdiom
        var scale : CGFloat = (idiom == .pad ? 76 : 60) - 10
        let im = UIImage(named:"sunglasses.png")!
        let largerSize = fmax(im.size.height, im.size.width)
        scale /= largerSize
        let sz = CGSize(im.size.width*scale, im.size.height*scale)
        self.image = imageOfSize(sz) {
            im.draw(in:CGRect(origin: CGPoint(), size: sz))
        }
        super.init()
    }
    
    override class func activityCategory() -> UIActivityCategory {
        return .action // the default
    }
    
    override func activityType() -> String? {
        return "com.neuburg.matt.elaborateActivity"
    }
    
    override func activityTitle() -> String? {
        return "Elaborate"
    }
    
    override func activityImage() -> UIImage? {
        return self.image
    }
    
    override func canPerform(withActivityItems activityItems: [AnyObject]) -> Bool {
        print("elaborate can perform \(activityItems)")
        print("returning true")
        return true
    }
    
    override func prepare(withActivityItems activityItems: [AnyObject]) {
        print("elaborate prepare \(activityItems)")
        self.items = activityItems
    }
    
    override func activityViewController() -> UIViewController? {
        let mvc = MustacheViewController(activity: self, items: self.items!)
        return mvc
    }
    
    deinit {
        print("elaborate activity dealloc")
    }
    
}
