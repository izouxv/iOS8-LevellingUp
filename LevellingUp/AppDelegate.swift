//
// Copyright 2015 Scott Logic
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

let userNotificationSettingsKey = "UserNotificationSettingsDidChange"
let localNotificationFiredKey = "LocalNotificationFired"
let localNotificationTriggeredActionKey = "LocalNotificationTriggeredAction"


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    let splitViewController = self.window!.rootViewController as! UISplitViewController
    splitViewController.delegate = self
    return true
  }
  
  
  // MARK: - Notification Settings
  func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    NSNotificationCenter.defaultCenter().postNotificationName(userNotificationSettingsKey, object: self)
  }
  
  // MARK: - Local notification fired
  func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    NSNotificationCenter.defaultCenter().postNotificationName(localNotificationFiredKey, object: self, userInfo: ["notification": notification])
  }
  
  // MARK: - Action handling
  func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
    if let identifier = identifier {
      let info = ["notification" : notification, "identifier" : identifier]
      NSNotificationCenter.defaultCenter().postNotificationName(localNotificationTriggeredActionKey, object: self, userInfo: info)
    }
    completionHandler()
  }
}

