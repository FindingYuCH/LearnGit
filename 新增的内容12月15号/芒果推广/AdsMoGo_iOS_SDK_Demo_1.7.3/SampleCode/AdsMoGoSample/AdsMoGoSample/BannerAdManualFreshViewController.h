//
//  BannerAdManualFreshViewController.h
//  AdsMoGoSample
//
//  Created by mogo on 14-7-12.
//  Copyright (c) 2014年 MOGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

@interface BannerAdManualFreshViewController : UIViewController<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate>{
    AdMoGoView *adView;
}

@property (nonatomic, retain) AdMoGoView *adView;

@end
