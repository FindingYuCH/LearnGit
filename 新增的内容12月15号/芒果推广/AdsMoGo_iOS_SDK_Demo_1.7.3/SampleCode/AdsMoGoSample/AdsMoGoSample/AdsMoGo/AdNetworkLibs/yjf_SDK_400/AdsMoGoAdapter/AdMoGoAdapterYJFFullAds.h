//
//  AdMoGoAdapterYJFFullAds.h
//  TestMOGOSDKAPP
//
//  Created by mogo_wenyand on 13-4-9.
//
//

#import "AdMoGoAdNetworkInterstitialAdapter.h"
#import "AdMoGoAdNetworkAdapter.h"
#import <UIKit/UIKit.h>

@interface AdMoGoAdapterYJFFullAds : AdMoGoAdNetworkInterstitialAdapter{
    NSTimer *timer;
    BOOL isStop;
    BOOL isStopTimer;
    BOOL isReady;
}
+ (AdMoGoAdNetworkType)networkType;
- (void)getAd;
- (void)stopBeingDelegate;
- (void)stopTimer;
- (void)stopAd;
- (void)dealloc;
@end
