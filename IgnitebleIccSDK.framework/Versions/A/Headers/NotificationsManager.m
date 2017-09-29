//
//  NotificationsManager
//  Estimote Monitoring
//
//  Created by Sarkis Kaloustian on 8/20/17.
//  Copyright (c) 2017 Ignite BLE, LLC. All rights reserved.
//

#import "NotificationsManager.h"
#import "DeviceManagerEstimote.h"
#import <UIKit/UIKit.h>
#import <EstimoteSDK/EstimoteSDK.h>
#import "APIClientICC.h"


@interface NotificationsManager () <ESTMonitoringV2ManagerDelegate>

@property (nonatomic) DeviceManagerEstimote *deviceManager;
@property (nonatomic) ESTMonitoringV2Manager *monitoringManager;

@property (nonatomic) NSString *enterMessage;
@property (nonatomic) NSString *exitMessage;
@property (nonatomic) APIClientICC *apiClientICC;
@property (nonatomic) NSMutableDictionary *inOut;
@property (nonatomic) NSMutableDictionary *throttleEvent;
@property (nonatomic) NSMutableArray *beaconIdArray;
@property (nonatomic) NSMutableDictionary * eventData;

@end


@implementation NotificationsManager

+ (instancetype)sharedNotificationclient {
    static NotificationsManager *_sharedNotificationclient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedNotificationclient = [[self alloc] init];
    });
    return _sharedNotificationclient;
}


- (instancetype)init {
    self = [super init];
    //NSLog(@"-------------notificationManager init -------------");
    // Remember messages to show
    self.enterMessage = @"Enter";
    self.exitMessage = @"Exit";
    
    self.inOut = [NSMutableDictionary dictionary];
    
    if (self) {
        _monitoringManager = [[ESTMonitoringV2Manager alloc] initWithDesiredMeanTriggerDistance:1.5 delegate:self];
        _monitoringManager.delegate = self;
        NSURL *baseURL = [NSURL URLWithString:@"http://dev.igniteble.com/"];
        self.apiClientICC = [APIClientICC sharedAPIclient];
        self.apiClientICC.baseURL = baseURL;
        self.locationId = @"00000000-0000-0000-0000-000000000000";
        self.enableSystemTelemetryNotificaitons = TRUE;
        self.enableAnalytics = FALSE;
        self.throttleInSec = 60;
    }
    
    return self;
}


- (void)enableNotificationsForDeviceIdentifier {
    
    // Set up local notifications
    //    UIUserNotificationType notificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound);
    //    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificationTypes
    //                                                                                         categories:nil];
    //    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
   // enableSystemTelemetryNotificaitons
    
    if(self.enableSystemTelemetryNotificaitons){
        self.deviceManager = [DeviceManagerEstimote sharedICCDeviceManager];
        self.deviceManager.enableAnalytics = self.enableAnalytics;
        self.deviceManager.throttleInSec = self.throttleInSec;
        [self.deviceManager enableDeviceManager:self.companyId];
    }

    [self updateMonitoringIds];

}

- (void)updateMonitoringIds  {
    

    [[APIClientICC sharedAPIclient] getBeacons:self.companyId locationId:self.locationId
      success:^(NSDictionary *rawLocationData){
        //NSLog(@"Send Data Success of %@", rawLocationData);
          self.beaconIdArray = [NSMutableArray array];
          for(NSDictionary *item in rawLocationData) {
              //NSLog(@"Item: %@", [item objectForKey:@"beaconId"]);
              [self.beaconIdArray addObject: [item objectForKey:@"beaconId"]];
          }
          // Start monitoring
          [self.monitoringManager startMonitoringForIdentifiers:self.beaconIdArray];
          NSLog(@"Item: %@", self.beaconIdArray);
          //NSLog(@"Get monitoredIdentifiers %@", [self.monitoringManager monitoredIdentifiers]);
          
    } failure:^(NSString *errorMessage) {
        NSLog(@"Get Beacon ids Data Error of %@", errorMessage);
    }];

    
}

#pragma mark Private

- (void)showNotificationWithMessage:(NSString *)message {
    //UILocalNotification *notification = [UILocalNotification new];
    //notification.alertBody = message;
    //notification.soundName = UILocalNotificationDefaultSoundName;
    //[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


- (void)sendNotificationWithMessage:(NSString *)identifier
                        typeOfEvent:(NSString *)typeOfEvent {
    
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    double dwellTime = 0;
    //get dwell time on exit
    if([typeOfEvent isEqual: @"Exit"]){
        
        if(self.inOut[identifier]){
            NSDate *exitTime = [NSDate date];
            NSDate *enterTime=self.inOut[identifier];
            dwellTime = [exitTime timeIntervalSinceDate:enterTime];
            [self.inOut removeObjectForKey:identifier];
            //NSLog(@"+++++++ Dwell Time: %f +++++++", dwellTime);
        }
    }

    self.eventData = [[NSMutableDictionary alloc] init];
    self.eventData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                typeOfEvent,@"typeOfEvent",
                                uuid,@"deviceId",
                                identifier,@"beaconId",
                                [NSNumber numberWithDouble:dwellTime],@"dwellTime",
                                nil];
    
    NSString *path = @"api/beacon/data";
    [[APIClientICC sharedAPIclient] sendEstimoteMonitoring:self.eventData path:path
                                                   success:^{
                                                       NSLog(@"Send Data Success of %@", self.eventData);
                                                   } failure:^(NSString *errorMessage) {
                                                       NSLog(@"Send Data Error of %@ %@", self.eventData, errorMessage);
                                                   }];
}


#pragma mark - ESTMonitoringV2ManagerDelgate

- (void)monitoringManager:(ESTMonitoringV2Manager *)manager didEnterDesiredRangeOfBeaconWithIdentifier:(NSString *)identifier {
    NSLog(@"Entered desired range of %@", identifier);

    // track enter time for dwell time
    NSDate *now = [NSDate date];
    [self.inOut setObject:now  forKey:identifier];
    
    [self sendNotificationWithMessage:identifier typeOfEvent:self.enterMessage];
    
}

- (void)monitoringManager:(ESTMonitoringV2Manager *)manager didExitDesiredRangeOfBeaconWithIdentifier:(NSString *)identifier {
    
    NSLog(@"Exited desired range of %@", [identifier stringByAppendingString:@" Exited desired range of"]);
    [self sendNotificationWithMessage:identifier typeOfEvent:self.exitMessage];
    
    //[self showNotificationWithMessage:[ self.exitMessage stringByAppendingString: identifier ]];
}

- (void)monitoringManager:(ESTMonitoringV2Manager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Monitoring failed. Error: %@", error);
}





@end
