//
//  ChecOutViewController.h
//  TestMOGOSDKAPP
//
//  Created by mogo_wenyand on 14-1-21.
//
//

#import <UIKit/UIKit.h>
#import "AdMoGoAppUpdateRemind.h"
#import "AdMoGoAppUpdateRemindDelegate.h"

@interface ChecOutViewController : UIViewController <AdMoGoAppUpdateRemindDelegate> {
    NSString *appkey;
    AdMoGoAppUpdateRemind *updateRemindAlert;
    AdMoGoAppUpdateRemind *updateRemind;
    AdMoGoAppUpdateRemind *immediateUpdateAlert;
    AdMoGoAppUpdateRemind *immediateUpdate;
    Boolean usecustomVersion;
}

@property (nonatomic, assign) NSString *appkey;

@end
