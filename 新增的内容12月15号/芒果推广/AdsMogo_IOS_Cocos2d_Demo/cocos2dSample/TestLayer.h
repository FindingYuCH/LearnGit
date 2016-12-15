//
//  TestLayer.h
//  cocos2dSample
//
//  Created by cihui yu on 2016/12/14.
//  Copyright © 2016年 Chasel. All rights reserved.
//

#import "CCLayer.h"
#import "AdMoGoInterstitialManager.h"
#import "cocos2d.h"


@interface TestLayer : CCLayer<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate,AdMoGoInterstitialDelegate>{
    
    AdMoGoView * mogoView;
    AdMoGoView * mogoView2;
}


+ (CCScene *) scene;
@end
