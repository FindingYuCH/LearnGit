//
//  AdMoGoAdapterBaiduSplashCustom.m
//  wanghaotest
//
//  Created by mogo on 13-11-15.
//
//

#import "AdMoGoAdapterBaiduSplashCustom.h"

@interface AdMoGoAdapterBaiduSplashCustom()

@property (nonatomic, copy) NSString *appid;

@end

@implementation AdMoGoAdapterBaiduSplashCustom

+ (AdMoGoAdNetworkType)networkType
{
    return AdMoGoAdNetworkTypeCustomEventPlatform_2;
}

+ (void)load
{
    [super registerClass:self];
}

- (void)getAd
{
    isFail = NO;
    isSuccess = NO;
    splash = [[BaiduMobAdSplash alloc] init];
    splash.delegate = self;

    [self customAdapterWillgetAdAndGetAdViewType];
    
    self.appid = [self getAPPID_F];
    NSString* adPlaceID = [self getAPPID_S];
    splash.AdUnitTag = adPlaceID;
    splash.canSplashClick = YES;
    [splash loadAndDisplayUsingKeyWindow:[self getWindow]];
    
    [self adMoGoCustomDidStartRequest:self];
    
    id _timeInterval = [self.ration objectForKey:@"to"];
    if ([_timeInterval isKindOfClass:[NSNumber class]]) {
        timer = [[NSTimer scheduledTimerWithTimeInterval:[_timeInterval doubleValue] target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    } else {
        timer = [[NSTimer scheduledTimerWithTimeInterval:AdapterTimeOut5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    }
}

- (void)stopTimer
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)stopBeingDelegate
{
    if(splash){
        splash.delegate = nil;
        [splash release],splash = nil;
    }
}

- (void)loadAdTimeOut:(NSTimer*)theTimer
{
    [super loadAdTimeOut:theTimer];
    
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [self stopBeingDelegate];
    [self adFailWith:nil];
}

- (void)dealloc
{
    self.appid = nil;
    
    [super dealloc];
}


/**
 *  应用在union.baidu.com上的APPID
 */
- (NSString *)publisherId
{
    return self.appid;
}

/**
 *  广告被点击
 */
- (void)splashDidClicked:(BaiduMobAdSplash *)splash
{
    [self adMogoCustomDidClick:self];
}

/**
 *  广告展示成功
 */
- (void)splashSuccessPresentScreen:(BaiduMobAdSplash *)splash
{
    [self stopTimer];
    [self adSuccess:splash];
    [self adMogoCustomDidPresent:self withSplash:splash];
}

/**
 *  广告展示失败
 */
- (void)splashlFailPresentScreen:(BaiduMobAdSplash *)splash withError:(BaiduMobFailReason) reason
{
    [self stopTimer];
    [self adFailWith:nil];
}

/**
 *  广告展示结束
 */
- (void)splashDidDismissScreen:(BaiduMobAdSplash *)splash
{
    [self adMogoCustomDidDismiss:self withSplash:splash];
}

- (void)adSuccess:(id)_awSplash
{
    if (isSuccess==isFail && isSuccess == NO)
    {
        isSuccess = YES;
        [self adMoGoCustomSplashSuccess:self withSplash:_awSplash];
    }
}

- (void)adFailWith:(NSError *)error
{
    if (isSuccess==isFail && isFail == NO)
    {
        isFail = YES;
        [self adMoGoCustomSplashFail:self withError:error];
    }
}

@end
