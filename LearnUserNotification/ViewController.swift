//
//  ViewController.swift
//  LearnUserNotification
//
//  Created by HungPB on 8/23/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBAction func pushNotificationTapped(_ sender: Any) {
        pushNotification(inSeconds: 5) { success in
            if success {
                print("Success to get notification")
            }else{
                print("False to get notificaiton")
            }
        }
    }
    
    
    func pushNotification(inSeconds: TimeInterval, completion: @escaping(Bool) -> Void ){
        let path = "https://media1.giphy.com/media/3o6ozlN98tZiNQ9bwY/source.gif"
        let myUrl = URL(string: path)!
        let myAttachment = try! UNNotificationAttachment(identifier: "randomGif", url: myUrl, options: nil)
        
        let notifContent = UNMutableNotificationContent()
        
        notifContent.title = "New notification"
        notifContent.subtitle = "These are greate!"
        notifContent.body = "The new notification options is IOS 10 are whate I've always dream of!"
        notifContent.attachments = [myAttachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notifContent, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            }else{
                completion(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            if granted {
                print("Notification access granted")
            }else{
                print(error?.localizedDescription)
            }
        }
    }


}

