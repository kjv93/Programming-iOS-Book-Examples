

import UIKit
func delay(_ delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}
extension CGVector {
    init (_ dx:CGFloat, _ dy:CGFloat) {
        self.init(dx:dx, dy:dy)
    }
}



class RootViewController: UITableViewController {
    
    var pep : [String]! = ["Manny", "Moe", "Jack"] // pretend model might not be ready
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl!.addTarget(self, action: "doRefresh", forControlEvents: .ValueChanged)
        
        // uncomment to show that the refresh control is hidden behind the background view
//        let v = UIView()
//        v.backgroundColor = UIColor.yellow()
//        self.tableView.backgroundView = v
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.pep == nil {
            return 0
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pep.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) 

        cell.textLabel!.text = pep[indexPath.row]
        return cell
    }

    @IBAction func doRefresh(_ sender: AnyObject) {
        print("refreshing...")
        delay(3) {
            (sender as! UIRefreshControl).endRefreshing()
            print("done")
        }
    }

    @IBAction func doRefreshManually(_ sender: AnyObject) {
        self.tableView.setContentOffset(
            CGPoint(0, -self.refreshControl!.bounds.height),
            animated:true)
        self.refreshControl!.beginRefreshing()
        self.doRefresh(self.refreshControl!)
    }
}
