//
// Please report any problems with this app template to contact@estimote.com
//

#import <Foundation/Foundation.h>

@interface NotificationsManager : NSObject

    - (void)setMemberId:(NSString *)memberId;


    @property (nonatomic)  NSString *companyId;
    @property (nonatomic, copy) NSString *locationId;
    @property (nonatomic, copy) NSString *memberId;

    @property (nonatomic) bool enableSystemTelemetryNotificaitons;
    @property (nonatomic) bool enableAnalytics;
    @property (nonatomic) int throttleInSec;

    + (instancetype)sharedNotificationclient;
    - (void)updateMonitoringIds;
    - (void)enableNotificationsForDeviceIdentifier;

@end
