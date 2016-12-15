//
//  FullAdNoAutopollingViewController.h
//  AdsMoGoSample
//
//  Created by mogo on 14-3-6.
//  Copyright (c) 2014年 MOGO. All rights reserved.
//


#import "AdMoGoInterstitial.h"
#import "AdMoGoInterstitialDelegate.h"

@interface FullAdManualFreshViewController : UIViewController<AdMoGoInterstitialDelegate,AdMoGoWebBrowserControllerUserDelegate> {
    AdMoGoInterstitial *adView;
    BOOL isfullscreen;
    UILabel *statusLabel;
    BOOL adsMoGoDownloadShowAlert;
}

@property (nonatomic, retain) AdMoGoInterstitial *adView;
@property (nonatomic,retain) NSString *appkey;
@property(nonatomic,assign) NSTimer *timer;

@end
