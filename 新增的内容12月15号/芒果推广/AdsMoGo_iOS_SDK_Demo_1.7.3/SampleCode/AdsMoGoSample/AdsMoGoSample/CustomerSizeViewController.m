//
//  CustomerSizeViewController.m
//  AdsMoGoSample
//
//  Created by MOGO on 14-11-14.
//  Copyright (c) 2014年 MOGO. All rights reserved.
//

#import "CustomerSizeViewController.h"

@interface CustomerSizeViewController () {
    AdMoGoView *adView;
}

@end

@implementation CustomerSizeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    adView = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPhone
                                         adType:AdViewTypeCustomSize                                adMoGoViewDelegate:self];
    adView.adWebBrowswerDelegate = self;
    
    adView.frame = CGRectMake(0.0, 100.0, 320.0, 50.0);
    [self.view addSubview:adView];
    [adView release];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGSize)adMoGoCustomSize
{
    return CGSizeMake(300, 300);
}

@end
