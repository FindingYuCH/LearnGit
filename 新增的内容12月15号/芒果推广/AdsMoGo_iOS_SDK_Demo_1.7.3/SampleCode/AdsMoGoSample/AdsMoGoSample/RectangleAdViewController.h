//
//  RectangleAdViewController.h
//  MoGoSample_iPad
//
//  Created by MOGO on 12-12-21.
//
//

#import <UIKit/UIKit.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

@interface RectangleAdViewController : UIViewController<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate> {
    AdMoGoView *_rectAd;
}

@property(nonatomic,retain) AdMoGoView *rectAd;

@end
