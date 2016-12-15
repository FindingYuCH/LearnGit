//
//  AdMoGoAdapterBaiduSplashCustom.h
//  wanghaotest
//
// 百度开屏自定义平台Demo
//
//  Created by mogo on 13-11-15.
//
//

#import "AdMoGoSplashAdapterCustomEvent.h"
#import "BaiduMobAdSplash.h"
#import "BaiduMobAdSplashDelegate.h"

@interface AdMoGoAdapterBaiduSplashCustom : AdMoGoSplashAdapterCustomEvent <BaiduMobAdSplashDelegate> {
    BaiduMobAdSplash *splash;
    BOOL isLocationOn;
    NSTimer *timer;
    BOOL isFail;
    BOOL isSuccess;
}

+ (AdMoGoAdNetworkType)networkType;
- (void)loadAdTimeOut:(NSTimer*)theTimer;

@end
