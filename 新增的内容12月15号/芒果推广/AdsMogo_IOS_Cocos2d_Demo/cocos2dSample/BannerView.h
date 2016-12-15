//
//  BannerView.h
//  cocos2dSample
//
//  Created by Chasel on 14-1-20.
//  Copyright 2014年 Chasel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AdMoGoView.h"
@interface BannerView : CCNode {
    
}

-(void)requestInterstitial:(NSString *)mogoID isManualRefresh:(BOOL)isManualRefresh;
-(void)showInterstitial:(BOOL)isShow withMogoID:(NSString *)mogoID;
-(void)cancelInterstitial:(NSString *)mogoID;
-(void)releaseInterstitial:(NSString *)mogoID;

-(void)showBanner:(BOOL)isManualRefresh;

-(void)showmanualRefreshBanner;


-(void)releaseBannerMethod;


-(void)refreshAd;

-(void)manualRefreshBanner;

-(void)manualRefreshInterstitial;


@end
