//
//  AppDelegate.h
//  T2
//
//  Created by Brammanand on 25/12/14.
//  Copyright (c) 2014 Telibrahma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

extern NSString *kAlarmNotificationKey;

@end
