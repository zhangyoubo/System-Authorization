//
//  ViewController.m
//  System Authorization
//
//  Created by 张友波 on 2017/5/24.
//  Copyright © 2017年 张友波. All rights reserved.
//

// http://www.jianshu.com/p/27e57922232b

/**
 * 
 权限分类
 
 联网权限
 相册权限
 相机、麦克风权限
 定位权限
 推送权限
 通讯录权限
 日历、备忘录权限
 *

 */

#import "ViewController.h"

@import CoreTelephony;
@import CallKit;
@import Photos;
@import CoreLocation;
@import Contacts;
@import AVFoundation;
@import UserNotifications;
@import EventKit;

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

#pragma mark - 网络权限
- (IBAction)cellularEvent:(id)sender {
    // 检测应用联网状态
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
            case kCTCellularDataRestricted:
                NSLog(@"Restricrted");
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"Not Restricted");
                break;
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"Unknown");
                break;
            default:
                break;
        };
    };
    // 查询应用是否有联网功能
    CTCellularDataRestrictedState state = cellularData.restrictedState;
    switch (state) {
        case kCTCellularDataRestricted:
            NSLog(@"Restricrted");
            break;
        case kCTCellularDataNotRestricted:
            NSLog(@"Not Restricted");
            break;
        case kCTCellularDataRestrictedStateUnknown:
            NSLog(@"Unknown");
            break;
        default:
            break;
    }
    
}
#pragma mark - 相册权限
- (IBAction)photoEvent:(id)sender {
    // 检查是否有相册权限
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case PHAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case PHAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case PHAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    // 获取相册权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
    
}
#pragma mark - 相机权限
- (IBAction)cameraEvent:(id)sender {
    // 检查是否有相机
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    
    switch (AVstatus) {
        case AVAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case AVAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case AVAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case AVAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
    
}
#pragma mark - 麦克风权限
- (IBAction)microphoneEvent:(id)sender {
    // 检查是否有麦克风权限
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    switch (AVstatus) {
        case AVAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case AVAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case AVAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case AVAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }

    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {//麦克风权限
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
}
#pragma mark - 定位权限
- (IBAction)locationEvent:(id)sender {
    // 检查是否有定位权限
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        NSLog(@"not turn on the location");
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Authorized");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"AuthorizedWhenInUse");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    
    // 获取定位权限
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];//一直获取定位信息
    //[_locationManager requestWhenInUseAuthorization];//使用的时候获取定位信息
    
    
}
#pragma mark - 通讯录权限
- (IBAction)contactEvent:(id)sender {
    // 检查是否有通讯录权限
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusAuthorized:
        {
            NSLog(@"Authorized:");
        }
            break;
        case CNAuthorizationStatusDenied:{
            NSLog(@"Denied");
        }
            break;
        case CNAuthorizationStatusRestricted:{
            NSLog(@"Restricted");
        }
            break;
        case CNAuthorizationStatusNotDetermined:{
            NSLog(@"NotDetermined");
        }
            break;
            
    }
    // 获取通讯录权限
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
            NSLog(@"Authorized");
            
        }else{
            
            NSLog(@"Denied or Restricted");
        }
    }];
    
}
#pragma mark - 通知权限
- (IBAction)notificationEvent:(id)sender {
    // 检查是否有通知权限
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8.0)&&([[[UIDevice currentDevice] systemVersion]intValue]<10.0)) {
        UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        switch (settings.types) {
            case UIUserNotificationTypeNone:
                NSLog(@"None");
                break;
            case UIUserNotificationTypeAlert:
                NSLog(@"Alert Notification");
                break;
            case UIUserNotificationTypeBadge:
                NSLog(@"Badge Notification");
                break;
            case UIUserNotificationTypeSound:
                NSLog(@"sound Notification'");
                break;
                
            default:
                break;
        }
        // 获取推送权限
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        
    }else if ([[[UIDevice currentDevice] systemVersion]intValue]>=10.0) {
        // 检查是否有通知权限
        UNUserNotificationCenter *remoteCenter = [UNUserNotificationCenter currentNotificationCenter];
        
        [remoteCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings){
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusAuthorized:
                    NSLog(@"Authorized");
                    break;
                case UNAuthorizationStatusDenied:
                    NSLog(@"Denied");
                    break;
                case UNAuthorizationStatusNotDetermined:
                    NSLog(@"Not Determined");
                    break;
                default:
                    break;
            }
            
        }];
        
        // 获取推送权限
        [remoteCenter requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"请求成功");
            } else {
                NSLog(@"请求失败");
            }
        }];

    }
   
}

#pragma mark - 备忘录权限
- (IBAction)reminderEvent:(id)sender {
    // 检查是否有备忘录权限
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeReminder];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case EKAuthorizationStatusDenied:
            NSLog(@"Denied'");
            break;
        case EKAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case EKAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    // 获取备忘录权限
    EKEventStore *store = [[EKEventStore alloc]init];
    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
}
- (IBAction)calendarEvent:(id)sender {
    // 检查是否有日历权限
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case EKAuthorizationStatusDenied:
            NSLog(@"Denied'");
            break;
        case EKAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case EKAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    // 获取日历权限
    EKEventStore *store = [[EKEventStore alloc]init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];

}


@end
























