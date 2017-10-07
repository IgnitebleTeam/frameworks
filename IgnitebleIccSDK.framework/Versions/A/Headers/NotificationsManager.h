//
// Please report any problems with this app template to contact@estimote.com
//

#import <Foundation/Foundation.h>

@interface NotificationsManager : NSObject

    @property (nonatomic) NSString *companyId;
    @property (nonatomic) NSString *locationId;
    @property (nonatomic) NSString *memberId;

    @property (nonatomic) bool enableSystemTelemetryNotificaitons;
    @property (nonatomic) bool enableAnalytics;
    @property (nonatomic) int throttleInSec;

    + (instancetype)sharedNotificationclient;
    - (void)updateMonitoringIds;
    - (void)enableNotificationsForDeviceIdentifier;
    - (void)setYourMemberId:(NSString *)memberId;

@end
