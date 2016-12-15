//
//  MediumBannerAdViewController.h
//  MoGoSample_iPad
//
//  Created by MOGO on 12-12-21.
//
//

#import <UIKit/UIKit.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

@interface MediumBannerAdViewController : UIViewController<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate> {
    AdMoGoView *_mediumAd;
}

@property(nonatomic,retain) AdMoGoView *mediumAd;

@end
