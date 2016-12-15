//
//  manualRefreshLayer.m
//  cocos2dSample
//
//  Created by Chasel on 14/7/14.
//  Copyright (c) 2014年 Chasel. All rights reserved.
//

#import "manualRefreshLayer.h"
#import "HelloWorldLayer.h"
#import "BannerView.h"
#import "AppDelegate.h"



@implementation manualRefreshLayer



// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    manualRefreshLayer *layer = [manualRefreshLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super's" return value
    if( (self=[super init]) ) {
        
        
        if (!bannview) {
            bannview=[[BannerView alloc]init];
        }
        
        //		// create and initialize a Label
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cocos2dSample-manualRefresh" fontName:@"Marker Felt" fontSize:40];
        
        //		// ask director for the window size
        CGSize size = [[CCDirector sharedDirector] winSize];
        //
        //		// position the label on the center of the screen
        label.position =  ccp( size.width /2 , size.height-50 );
        //
        //		// add the label as a child to this Layer
        [self addChild: label];
        
        
        [CCMenuItemFont setFontSize:20];
        
        // to avoid a retain-cycle with the menuitem and blocks
        
        // Achievement Menu Item using blocks
        CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"横幅" block:^(id sender) {
            [bannview showmanualRefreshBanner];
        }];
        
        // Leaderboard Menu Item using blocks
        CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"获取全插屏" block:^(id sender) {
            [bannview requestInterstitial:MogoAppKey_iphone1 isManualRefresh:YES];
            
        }];
        CCMenuItem *WallitemLeaderboard = [CCMenuItemFont itemWithString:@"手动刷新" block:^(id sender) {
            [bannview manualRefreshBanner];

        }];
        
        
        CCMenuItem *iteam_back = [CCMenuItemFont itemWithString:@"返回" block:^(id sender) {
            [self showHelloWord];
        }];
        
        CCMenuItem *showitemLeaderboard = [CCMenuItemFont itemWithString:@"显示全插屏" block:^(id sender) {
            [bannview showInterstitial:YES withMogoID:MogoAppKey_iphone1];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard,showitemLeaderboard,WallitemLeaderboard,iteam_back,nil];
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp(size.width/2, size.height/2 - 50)];
        
        // Add the menu to the layer
        [self addChild:menu];
    }
    return self;
}


- (void) dealloc
{
 
    [super dealloc];
}


-(void)showHelloWord{
    [[CCDirector sharedDirector] popToRootScene];
}


#pragma mark GameKit delegate
//
-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}
//
-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}


@end
