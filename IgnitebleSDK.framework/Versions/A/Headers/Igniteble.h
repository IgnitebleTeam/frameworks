//
//  Igniteble.h
//  Igniteble
//
//  Created by Peter Dupris on 1/14/15.
//  Copyright (c) 2016 Ignite BLE, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Igniteble : NSObject

+ (instancetype)sharedManager;
@property (nonatomic, copy) NSURL *baseURL;
@property (nonatomic) NSString *inboxBackgroundImageName; //Custom background image should be included in your application. Internally using [UIImage imageNamed:].

//Setup
//Notifications
- (void)registerForNotifications;
//Location Authorization
- (BOOL)needsLocationAuthorization;
- (void)requestLocationAuthorization;

// UINavigationController wrapper for the Inbox. Should be presented modally.
- (UINavigationController*)ignitebleInbox;

//Notifications helpers
- (void)setRemoteNotificationsDeviceToken:(NSData *)remoteNotificationsDeviceToken;
- (BOOL)handleLocalNotification:(UILocalNotification*)notification; //Will return YES if the notification is handled by Igniteble SDK. If NO is returned, then the notification did not originate from Igniteble and should be handled by the application.

// UINavigationController full of debug views. Should be presented modally.
- (UINavigationController*)debugViewController;

//Observable properties
@property (nonatomic, readonly) NSString *deviceID; //Key value observable
@property (nonatomic, readonly) BOOL beaconsDetected; //Key value observable

//Version Info
+ (NSString*)version;

//Bluetooth Status
@property (nonatomic, readonly) BOOL bluetoothEnabled; //Returns YES if bluetooth is enabled.
@property (nonatomic, readonly) BOOL canTurnOnBluetooth; //Returns YES if the user can turn on bluetooth. Returns NO if the device does not have bluetooth capability, or bluetooth can not be turned on because the user is unauthorized to do so.
- (void)showBluetoothAlertIfNeeded; //Will show an alert if bluetooth is not enabled, and the user can turn on bluetooth.

@property (nonatomic) NSUInteger notificationLimitPerMonth;
@property (nonatomic, readonly) NSUInteger notificationsThisMonth;
- (void)resetNotificationCount;

@property (nonatomic) BOOL updateApplicationIconBadgeNumber; //Set to YES to allow Igniteble to update your app's icon badge number to the number of unread items in the Igniteble inbox.. If enabled, you should not update the badge manually.

@end
