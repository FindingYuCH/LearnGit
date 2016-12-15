//
//  TestLayer.m
//  cocos2dSample
//
//  Created by cihui yu on 2016/12/14.
//  Copyright © 2016年 Chasel. All rights reserved.
//

#import "TestLayer.h"



@implementation TestLayer

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    TestLayer *layer = [TestLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (id) init{
    self = [super init];
    if (self) {
        // ffd6064c2cc74da6909a92ab353f675f
        
        
        mogoView = [[AdMoGoView alloc] initWithAppKey:@"bb0bf739cd8f4bbabb74bbaa9d2768bf" adType:AdViewTypeiPhoneRectangle adMoGoViewDelegate:self];
        mogoView.adWebBrowswerDelegate = self;
        [mogoView setViewPointType:AdMoGoViewPointTypeMiddle_middle];
        [[[CCDirector sharedDirector] view] addSubview: mogoView];
        
        mogoView2 = [[AdMoGoView alloc] initWithAppKey:@"bb0bf739cd8f4bbabb74bbaa9d2768bf" adType:AdViewTypeNormalBanner adMoGoViewDelegate:self];
        mogoView2.adWebBrowswerDelegate = self;
        [mogoView2 setViewPointType:AdMoGoViewPointTypeTop_left];
        [[[CCDirector sharedDirector] view] addSubview: mogoView2];
    }
    
    
    return self;
    
}

- (UIViewController * ) viewControllerForPresentingModalView{
    
    return  [CCDirector sharedDirector];
}



- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告开始请求回调");
}


- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告接收成功回调");
}


- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error
{
    NSLog(@"广告接收失败回调");
    
    
}


- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"点击广告回调");
}


- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告关闭回调");
}

#pragma mark - AdMoGoWebBrowserControllerUserDelegate delegate


- (void)webBrowserWillAppear
{
    NSLog(@"浏览器将要展示");
}


- (void)webBrowserDidAppear
{
    NSLog(@"浏览器已经展示");
}


- (void)webBrowserWillClosed
{
    NSLog(@"浏览器将要关闭");
}


- (void)webBrowserDidClosed
{
    NSLog(@"浏览器已经关闭");
}

- (BOOL)shouldAlertQAView:(UIAlertView *)alertView
{
    return YES;
}

- (void)webBrowserShare:(NSString *)url { }



@end
