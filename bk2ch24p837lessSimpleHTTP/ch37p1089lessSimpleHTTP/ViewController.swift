

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate {

    @IBOutlet var iv : UIImageView!
    var task : NSURLSessionTask!
    
    let which = 1 // 0 or 1
    
    lazy var session : NSURLSession = {
        let config = NSURLSessionConfiguration.ephemeral()
        config.allowsCellularAccess = false
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.main())
        return session
    }()

    
    
    @IBAction func doElaborateHTTP (_ sender:AnyObject!) {
        if self.task != nil {
            return
        }
        
        let s = "http://www.apeth.net/matt/images/phoenixnewest.jpg"
        let url = NSURL(string:s)!
        let req = NSMutableURLRequest(url:url)
        if which == 1 { // show how to attach stuff to the request
            NSURLProtocol.setProperty("howdy", forKey:"greeting", in:req)
        }
        let task = self.session.downloadTask(with:req)
        self.task = task
        self.iv.image = nil
        task.resume()

    }
        
    func urlSession(_ session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {
        print("downloaded \(100*writ/exp)%")
    }
    
    func urlSession(_ session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        // unused in this example
    }
    
    func urlSession(_ session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print("completed: error: \(error)")
    }
    
    // this is the only required NSURLSessionDownloadDelegate method

    func urlSession(_ session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingTo location: NSURL) {
        if which == 1 {
            let req = downloadTask.originalRequest!
            if let greeting = NSURLProtocol.property(forKey:"greeting", in:req) as? String {
                print(greeting)
            }
        }
        self.task = nil
        let response = downloadTask.response as! NSHTTPURLResponse
        let stat = response.statusCode
        print("status \(stat)")
        if stat != 200 {
            return
        }
        let d = NSData(contentsOf:location)!
        let im = UIImage(data:d)
        dispatch_async(dispatch_get_main_queue()) {
            self.iv.image = im
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.session.finishTasksAndInvalidate()
    }
    
    deinit {
        print("farewell")
    }
    
}
