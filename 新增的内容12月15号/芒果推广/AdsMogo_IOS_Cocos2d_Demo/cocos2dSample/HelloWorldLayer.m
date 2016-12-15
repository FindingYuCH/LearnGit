//
//  HelloWorldLayer.m
//  cocos2dSample
//
//  Created by Chasel on 14-1-20.
//  Copyright Chasel 2014年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "BannerView.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "manualRefreshLayer.h"

#pragma mark - HelloWorldLayer


// HelloWorldLayer implementation
@implementation HelloWorldLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
 		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cocos2dSample" fontName:@"Marker Felt" fontSize:40];
 
//		// ask director for the window size
 		CGSize size = [[CCDirector sharedDirector] winSize];
//	
//		// position the label on the center of the screen
 		label.position =  ccp( size.width /2 , size.height/2 );
//		
//		// add the label as a child to this Layer
 		[self addChild: label];

		//
		// Leaderboards and Achievements
		//
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:20];
//
//		// to avoid a retain-cycle with the menuitem and blocks
//		
		// Achievement Menu Item using blocks
		CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"横幅" block:^(id sender) {
            [bannview showBanner:NO];
		}];
		
		// Leaderboard Menu Item using blocks
		CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"获取全插屏" block:^(id sender) {
            [bannview requestInterstitial:MogoAppKey_iphone2 isManualRefresh:NO];

		}];
        CCMenuItem *WallitemLeaderboard = [CCMenuItemFont itemWithString:@"手动刷新" block:^(id sender) {
            [self showManualRefresh];
		}];
        
        CCMenuItem *showitemLeaderboard = [CCMenuItemFont itemWithString:@"显示全插屏" block:^(id sender) {
            [bannview showInterstitial:YES withMogoID:MogoAppKey_iphone2];
		}];
//
        CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard,showitemLeaderboard,WallitemLeaderboard,nil];
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp(size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

//-(void) onEnter
//{
//    
//    
//    
////    [super onEnter];
////    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
//}

-(void)showManualRefresh{
     [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:1.0 scene:[manualRefreshLayer scene] ]];
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
