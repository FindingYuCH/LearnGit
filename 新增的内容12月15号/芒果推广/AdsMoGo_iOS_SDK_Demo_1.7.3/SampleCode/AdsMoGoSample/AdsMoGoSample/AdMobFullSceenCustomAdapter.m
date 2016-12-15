//
//  AdMobFullSceenCustomAdapter.m
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 14-3-17.
//  Copyright (c) 2014年 Daxiong. All rights reserved.
//

#import "AdMobFullSceenCustomAdapter.h"
#import <GoogleMobileAds/GADInterstitial.h>
#import <GoogleMobileAds/GADInterstitialDelegate.h>

@interface AdMobFullSceenCustomAdapter ()<GADInterstitialDelegate>
{
    BOOL isReady;
    GADInterstitial *gadinterstitial;
}
@end

@implementation AdMobFullSceenCustomAdapter

- (void)dealloc{

    gadinterstitial.delegate = nil;
    if (gadinterstitial) {
        [gadinterstitial release];
        gadinterstitial = nil;
    }
    
    [super dealloc];
}

/**
 *method load
 *register custom class
 *requirement
 */
+ (void)load{
    [self registerClass:self];
}


/**
 *AdMoGoAdNetworkTypeCustomEventPlatform_1
 *AdMoGoAdNetworkTypeCustomEventPlatform_2
 *AdMoGoAdNetworkTypeCustomEventPlatform_3
 */
+ (AdMoGoAdNetworkType)networkType{
    
    return AdMoGoAdNetworkTypeCustomEventPlatform_1;
    
}
- (void)getAd{
    
    isReady = NO;
    
    AdViewType type =[self customAdapterWillgetAdAndGetAdViewType];
    
	if (type == AdViewTypeFullScreen || type==AdViewTypeiPadFullScreen) {
        gadinterstitial = [[GADInterstitial alloc] init];
        gadinterstitial.delegate = self;
        gadinterstitial.adUnitID = [key objectForKey:APPID_FS_F];
        GADRequest *request = [GADRequest request];
        request.testDevices = [NSArray arrayWithObjects:nil];
        [gadinterstitial loadRequest:request];
        
        //did start(requirement)
        [self adMoGoFSCustom:self didStartRequestAd:gadinterstitial];
    }else{
        
        [self adMoGoFSCustom:self didFailAd:nil];
        
    }
    
    
}
- (BOOL)isReadyPresentInterstitial{
    
    return isReady;
    
}
- (void)presentInterstitial{
    
    // 呈现插屏广告
    [gadinterstitial presentFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    
}



#pragma mark -
#pragma mark GADInterstitialDelegate method

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    if (isStop) {
        return;
    }
    isReady = YES;
    
    //did receive(requirement)
    [self adMoGoFSCustom:self didReceiveInterstitialScreenAd:ad];
    
}

- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error{
    if (isStop) {
        return;
    }
    
    NSLog(@"admob's fullScreen ad is failed :%@",error);
    
    //did fail(requirement)
    [self adMoGoFSCustom:self didFailAd:error];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    
    if (isStop) {
        return;
    }
    //count click
    [self adMoGoFSCustomCountClick];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    
    if (isStop) {
        return;
    }
    
    //did dismiss(reeeeeeeeeeeeeeequirement)
    [self adMoGoFSCustom:self didDismissScreen:ad];
}


- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    
    if (isStop) {
        return;
    }
    
    //will present
    [self adMoGoFSCustom:self willPresent:ad];
}


@end
