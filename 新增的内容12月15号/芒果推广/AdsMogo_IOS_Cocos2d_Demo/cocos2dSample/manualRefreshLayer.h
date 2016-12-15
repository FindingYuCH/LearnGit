//
//  manualRefreshLayer.h
//  cocos2dSample
//
//  Created by Chasel on 14/7/14.
//  Copyright (c) 2014年 Chasel. All rights reserved.
//

#import "CCLayer.h"

#define MogoAppKey @"cc832e9716a14016bfad052ea84b09c9"
#define MogoAppKey_ipone @"ffd6064c2cc74da6909a92ab353f675f"

#import <GameKit/GameKit.h>
#import "BannerView.h"
#import "cocos2d.h"
@interface manualRefreshLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    BannerView * bannview;
}

+(CCScene *) scene;


@end
