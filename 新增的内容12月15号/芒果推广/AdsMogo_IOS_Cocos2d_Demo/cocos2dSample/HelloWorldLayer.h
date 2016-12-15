//
//  HelloWorldLayer.h
//  cocos2dSample
//
//  Created by Chasel on 14-1-20.
//  Copyright Chasel 2014年. All rights reserved.
//
#define MogoAppKey_iphone1 @"45f43fbe3e16489a83be12d2ce2b93ee"
#define MogoAppKey_iphone2 @"ffd6064c2cc74da6909a92ab353f675f"

#import <GameKit/GameKit.h>
#import "BannerView.h"
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
    BannerView * bannview;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
