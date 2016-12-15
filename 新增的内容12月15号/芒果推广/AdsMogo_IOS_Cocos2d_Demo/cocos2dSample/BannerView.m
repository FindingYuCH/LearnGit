//
//  BannerView.m
//  cocos2dSample
//
//  Created by Chasel on 14-1-20.
//  Copyright 2014年 Chasel. All rights reserved.
//

#import "BannerView.h"

#import "AppDelegate.h"

#import "AdMoGoInterstitial.h"
#import "AdMoGoInterstitialManager.h"
#import "AdMoGoLogCenter.h"
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


@interface BannerView ()<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate,AdMoGoInterstitialDelegate>{
    AdMoGoView *adbanner;
      AdMoGoInterstitial* interstitial;
}
@end
@implementation BannerView



-(void)showBanner:(BOOL)ismanualRefresh{
    adbanner= [[AdMoGoView alloc] initWithAppKey:@"ffd6064c2cc74da6909a92ab353f675f"
                                          adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:self
               adViewPointType:AdMoGoViewPointTypeDown_middle  isManualRefresh:ismanualRefresh];
    adbanner.adWebBrowswerDelegate = self;
    AppController * vc = (AppController*)[UIApplication sharedApplication].delegate;
    [vc.navController.visibleViewController.view addSubview:adbanner];
}

//手动刷新接口
-(void)showmanualRefreshBanner{
     adbanner= [[AdMoGoView alloc] initWithAppKey:@"45f43fbe3e16489a83be12d2ce2b93ee"
                                              adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:self
                                     adViewPointType:AdMoGoViewPointTypeTop_middle isManualRefresh:YES];
    adbanner.adWebBrowswerDelegate = self;
    AppController * vc = (AppController*)[UIApplication sharedApplication].delegate;
    [vc.navController.visibleViewController.view addSubview:adbanner];
}




-(void)manualRefreshBanner{
     [adbanner refreshAd];
     [interstitial refreshAd];
}

-(void)manualRefreshInterstitial{
    [interstitial refreshAd];
}








/*
 手动刷新接口 在芒果后台配置刷新时间为不刷新
 调用这个接口手动刷新横幅广告;
 如果设置的轮换时间不是不刷新,调用此接口无效.
 */
-(void)refreshAd{
//    [adbanner refreshAd]; //调用banner手动刷新接口
    [interstitial refreshAd]; //调用插屏手动刷新接口
}

//banner初始化成功回调接口
- (void)adMoGoInitFinish:(AdMoGoView *)adMoGoView{
}

//插屏请求成功回调接口
- (void)adMoGoInterstitialInitFinish{
}


-(void)requestInterstitial:(NSString *)mogoID  isManualRefresh:(BOOL)ismanualrefresh {
    //在使用手动刷新插屏的切勿使用 注释掉的代码，否则手动刷新将不起作用。
//    [AdMoGoInterstitialManager setAppKey:mogoID];
//    [[AdMoGoInterstitialManager shareInstance] initDefaultInterstitial];
//    [AdMoGoInterstitialManager setDefaultDelegate:self];
    interstitial= [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:mogoID isManualRefresh:ismanualrefresh];
    interstitial.adWebBrowswerDelegate = self;
}






-(void)showInterstitial:(BOOL)isShow withMogoID:(NSString *)mogoID{
   AdMoGoInterstitial* _interstitial= [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:mogoID];
    if (_interstitial) {
        [_interstitial interstitialShow:isShow];
    }
}





- (void)cancelInterstitial:(NSString *)mogoID{
    AdMoGoInterstitial* _interstitial= [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:mogoID];
    if (_interstitial) {
        [_interstitial interstitialCancel];
    }
}

- (void)releaseInterstitial:(NSString *)mogoID{
   [[AdMoGoInterstitialManager shareInstance] removeInterstitialInstanceByAppKey:mogoID];
}



  

#pragma marik --AdMoGoInterstitial
- (UIViewController *)viewControllerForPresentingInterstitialModalView{
    AppController * vc = (AppController*)[UIApplication sharedApplication].delegate;
    return vc.navController;
}



#pragma marik--AdMoGoBanner
- (UIViewController *)viewControllerForPresentingModalView{
  AppController * vc = (AppController*)[UIApplication sharedApplication].delegate;
    return vc.navController;
}

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear{

}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear{
    
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed{
    
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed{
    
}

/*
 浏览器分享
 url 浏览器打开url
 */
- (void)webBrowserShare:(NSString *)url{
    
}

-(void)dealloc{
    
    if (adbanner) {
        [adbanner release],adbanner=nil;
    }
//    if (interstitial) {
//        [interstitial release],interstitial=nil;
//    }
    
    
    
    [super dealloc];
}


@end
