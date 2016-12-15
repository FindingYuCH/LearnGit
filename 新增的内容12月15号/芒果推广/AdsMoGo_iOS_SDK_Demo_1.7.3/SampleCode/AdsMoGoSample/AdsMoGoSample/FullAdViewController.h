//
//  FullAdViewController20.h
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 14-5-5.
//  Copyright (c) 2014年 Daxiong. All rights reserved.
//

#import "AdMoGoInterstitial.h"
#import <UIKit/UIKit.h>

@interface FullAdViewController : UIViewController<AdMoGoInterstitialDelegate> {
    AdMoGoInterstitial *adView;
    BOOL isfullscreen;
    UILabel *statusLabel;
    BOOL adsMoGoDownloadShowAlert;
}

@property (nonatomic, retain) AdMoGoInterstitial *adView;
@property(nonatomic,assign) AdViewType adViewType;
@property(nonatomic,assign) NSString *appkey;
@property (nonatomic, assign) BOOL expressMode;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isVideo;
@property (nonatomic, assign) NSNumber *interval;
@property (nonatomic, assign) BOOL adsMoGoDownloadShowAlert;
@end
