

import UIKit

class RootViewController : UITableViewController {
    override var nibName : String { return "RootViewController" }
    
    var sectionNames = [String]()
    var sectionData = [[String]]()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        let s = try! String(contentsOfFile: NSBundle.main().pathForResource("states", ofType: "txt")!, encoding: NSUTF8StringEncoding)
        let states = s.components(separatedBy:"\n")
        var previous = ""
        for aState in states {
            // get the first letter
            let c = String(aState.characters.prefix(1))
            // only add a letter to sectionNames when it's a different letter
            if c != previous {
                previous = c
                self.sectionNames.append( c.uppercased() )
                // and in that case also add new subarray to our array of subarrays
                self.sectionData.append( [String]() )
            }
            sectionData[sectionData.count-1].append( aState )
        }
        self.tableView.register(MyCell.self, forCellReuseIdentifier: "Cell") // *
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")
        
        self.tableView.sectionIndexColor = UIColor.white()
        self.tableView.sectionIndexBackgroundColor = UIColor.red()
        self.tableView.sectionIndexTrackingBackgroundColor = UIColor.blue()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! MyCell // *
        let s = self.sectionData[indexPath.section][indexPath.row]
        cell.textLabel!.text = s
        
        // this part is not in the book, it's just for fun
        var stateName = s
        stateName = stateName.lowercased()
        stateName = stateName.replacingOccurrences(of:" ", with:"")
        stateName = "flag_\(stateName).gif"
        let im = UIImage(named: stateName)
        cell.imageView!.image = im
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let h = tableView
            .dequeueReusableHeaderFooterView(withIdentifier:"Header")!
        if h.tintColor != UIColor.red() {
            h.tintColor = UIColor.red() // invisible marker, tee-hee
            h.backgroundView = UIView()
            h.backgroundView?.backgroundColor = UIColor.black()
            let lab = UILabel()
            lab.tag = 1
            lab.font = UIFont(name:"Georgia-Bold", size:22)
            lab.textColor = UIColor.green()
            lab.backgroundColor = UIColor.clear()
            h.contentView.addSubview(lab)
            let v = UIImageView()
            v.tag = 2
            v.backgroundColor = UIColor.black()
            v.image = UIImage(named:"us_flag_small.gif")
            h.contentView.addSubview(v)
            lab.translatesAutoresizingMaskIntoConstraints = false
            v.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                NSLayoutConstraint.constraints(withVisualFormat:
                    "H:|-5-[lab(25)]-10-[v(40)]",
                    options:[], metrics:nil, views:["v":v, "lab":lab]),
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|[v]|",
                    options:[], metrics:nil, views:["v":v]),
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|[lab]|",
                    options:[], metrics:nil, views:["lab":lab])
                ].flatten().map{$0})
        }
        let lab = h.contentView.withTag(1) as! UILabel
        lab.text = self.sectionNames[section]
        return h
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionNames
    }
    
    // menu handling ==========
    
    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: NSIndexPath) -> Bool {
        let mi = UIMenuItem(title: "Abbrev", action: #selector(MyCell.abbrev))
        UIMenuController.shared().menuItems = [mi]
        return true
    }
    
    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return action == #selector(copy(_:)) || action == #selector(MyCell.abbrev)
    }
    
    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: NSIndexPath, withSender sender: AnyObject?) {
        if action == #selector(copy(_:)) {
            // ... do whatever copying consists of ...
            print("copying \(self.sectionData[indexPath.section][indexPath.row])")
        }
        if action == #selector(MyCell.abbrev) {
            // ... do whatever abbreviating consists of ...
            print("abbreviating \(self.sectionData[indexPath.section][indexPath.row])")
        }

    }
}

