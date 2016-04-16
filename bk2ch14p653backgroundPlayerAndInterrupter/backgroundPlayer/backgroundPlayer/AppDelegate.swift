
import UIKit
import AVFoundation

// nb test on device

func delay(_ delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    var timer : NSTimer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("bp in \(#function)")
        return; // comment out to perform timer experiment
        
        self.timer?.invalidate()
        self.timer = NSTimer.scheduledTimer(timeInterval:1, target: self, selector: #selector(fired), userInfo: nil, repeats: true)
    }
    
    // timer fires while we are in background, provided
    // (1) we scheduled it before going into the background
    // (2) we are running in the background (i.e. playing)
    func fired(_ timer:NSTimer) {
        print("bp timer fired")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("bp in \(#function)")
        print("bp state while entering background: \(application.applicationState.rawValue)")
        return; // comment out to experiment with background app performing immediate local notification
        
        delay(2) {
            print("bp trying to fire local notification")
            let ln = UILocalNotification()
            ln.alertBody = "Testing"
            application.presentLocalNotificationNow(ln)
        }
    }
    
    // we never receive this (if we are in background at the time)
    // but the notification does appear as banner/alert and in the notification center
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("bp got local notification reading \(notification.alertBody)")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("bp in \(#function)")
    }
    
    // we are a player app, we activate playback category only when we actually start playing
    // the rest of the time we use ambient just so we have an active category
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("bp in \(#function)")
        
        let types : UIUserNotificationType = .alert
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        application.register(settings)
        
        _ = try? AVAudioSession.sharedInstance().setActive(true)
        // new iOS 8 feature
        let mute = AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
        let s = mute ? "to" : "not"
        print("I need \(s) mute my secondary audio at this point")
    }
    
    // trying killing app from app switcher while playing in background;
    // we receive this!
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("bp in \(#function)")
    }
}
