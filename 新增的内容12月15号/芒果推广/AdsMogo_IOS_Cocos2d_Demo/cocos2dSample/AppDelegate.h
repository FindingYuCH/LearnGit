//
//  AppDelegate.h
//  cocos2dSample
//
//  Created by Chasel on 14-1-20.
//  Copyright Chasel 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "AdMoGoSplashAds.h"
#import "AdMoGoSplashAdsDelegate.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate,AdMoGoSplashAdsDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
