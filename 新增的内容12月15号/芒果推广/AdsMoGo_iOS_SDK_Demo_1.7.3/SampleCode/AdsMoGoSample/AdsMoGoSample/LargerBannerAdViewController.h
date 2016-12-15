//
//  LargerBannerAdViewController.h
//  MoGoSample_iPad
//
//  Created by MOGO on 12-12-21.
//
//

#import <UIKit/UIKit.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

@interface LargerBannerAdViewController : UIViewController<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate> {
    AdMoGoView *_largeAd;
}

@property(nonatomic,retain) AdMoGoView *largeAd;

@end
