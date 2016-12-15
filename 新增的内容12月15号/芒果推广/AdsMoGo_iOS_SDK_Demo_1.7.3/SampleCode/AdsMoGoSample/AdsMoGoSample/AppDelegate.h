//
//  AppDelegate.h
//  AdsMoGoSample
//
//  Created by MOGO on 13-11-21.
//  Copyright (c) 2013年 MOGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMoGoSplashAds.h"
#import "AdMoGoSplashAdsDelegate.h"
#import "MyNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,AdMoGoSplashAdsDelegate>{
    MyNavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@end
