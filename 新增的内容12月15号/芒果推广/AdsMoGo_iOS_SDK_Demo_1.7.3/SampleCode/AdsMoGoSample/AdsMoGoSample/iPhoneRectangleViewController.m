//
//  iPhoneRectangleViewController.m
//  AdsMoGoSample
//
//  Created by mogo on 14-5-22.
//  Copyright (c) 2014年 MOGO. All rights reserved.
//

#import "iPhoneRectangleViewController.h"

@implementation iPhoneRectangleViewController
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    adView = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPhone
                                         adType:AdViewTypeiPhoneRectangle                                adMoGoViewDelegate:self];
    adView.adWebBrowswerDelegate = self;
    
    //    typedef enum {
    //        AdViewTypeUnknown = 0,          //error
    //        AdViewTypeNormalBanner = 1,     //e.g. 320 * 50 ; 320 * 48  iphone banner
    //        AdViewTypeLargeBanner = 2,      //e.g. 728 * 90 ; 768 * 110 ipad only
    //        AdViewTypeMediumBanner = 3,     //e.g. 468 * 60 ; 508 * 80  ipad only
    //        AdViewTypeRectangle = 4,        //e.g. 300 * 250; 320 * 270 ipad only
    //        AdViewTypeSky = 5,              //Don't support
    //        AdViewTypeFullScreen = 6,       //iphone full screen ad
    //        AdViewTypeVideo = 7,            //Don't support
    //        AdViewTypeiPadNormalBanner = 8, //ipad use iphone banner
    //    } AdViewType;
    
//    adView.frame = CGRectMake(0.0, 100.0, 320.0, 50.0);
    [adView setViewPointType:AdMoGoViewPointTypeMiddle_middle];
    [self.view addSubview:adView];
    [adView release];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - AdMoGoDelegate delegate
/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告开始请求回调");
}

/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告接收成功回调");
}

/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error
{
    NSLog(@"广告接收失败回调");
}

/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"点击广告回调");
}

/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告关闭回调");
}

#pragma mark - AdMoGoWebBrowserControllerUserDelegate delegate

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear
{
    NSLog(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear
{
    NSLog(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed
{
    NSLog(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed
{
    NSLog(@"浏览器已经关闭");
}

/**
 *直接下载类广告 是否弹出Alert确认
 */
- (BOOL)shouldAlertQAView:(UIAlertView *)alertView
{
    return NO;
}

- (void)webBrowserShare:(NSString *)url { }

@end
