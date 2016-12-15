//
//  iPadNormalBannerAdViewController.h
//  MoGoSample_iPad
//
//  Created by MOGO on 12-12-21.
//
//

#import <UIKit/UIKit.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

@interface iPadNormalBannerAdViewController : UIViewController<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate> {
    AdMoGoView *_bannerAd;
}

@property(nonatomic,retain) AdMoGoView *bannerAd;

@end
