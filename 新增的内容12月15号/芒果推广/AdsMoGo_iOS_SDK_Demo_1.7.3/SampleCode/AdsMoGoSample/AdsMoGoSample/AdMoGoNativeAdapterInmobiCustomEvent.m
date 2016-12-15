//
//  AdMoGoNativeAdapterInmobiCustomEvent.m
//  mogoNativeDemo
//
//  Created by MOGO on 15-5-6.
//  Copyright (c) 2015年 ___ADSMOGO___. All rights reserved.
//

#import "AdMoGoNativeAdapterInmobiCustomEvent.h"
#import "IMNative.h"
#import "IMSdk.h"
#import "AdsMogoNativeAdInfo.h"
@implementation AdMoGoNativeAdapterInmobiCustomEvent
/**
 *method load
 *register custom class
 *requirement
 */
+ (void)load{
    [self registerClass:self];
}

/**
 * AdMoGoNativeAdNetworkTypeCustomEventPlatform_1
 * AdMoGoNativeAdNetworkTypeCustomEventPlatform_2
 * AdMoGoNativeAdNetworkTypeCustomEventPlatform_3
 */
+ (AdMoGoNativeAdNetworkType)networkType
{
    return AdMoGoNativeAdNetworkTypeCustomEventPlatform_1;
}

- (void)loadAd:(int)adcount
{
    [IMSdk setLogLevel:kIMSDKLogLevelDebug];
    id key = [self.ration objectForKey:@"k"];
    NSString *publisherAppId = nil;
    long long placemnetid = 0;
    if ([key isKindOfClass:[NSString class]]) {
        publisherAppId = key;
    } else  if ([key isKindOfClass:[NSDictionary class]]) {
        NSDictionary *keydict = (NSDictionary *)key;
        publisherAppId = [keydict objectForKey:APPID_Native_F];
        placemnetid = [[keydict objectForKey:APPID_Native_S] longLongValue];
    } else {
        [self adMoGoNativeCustom:self didFail:-1];
        return;
    }
    [IMSdk initWithAccountID:publisherAppId];
    self.native = [[IMNative alloc] initWithPlacementId:placemnetid];
    self.native.delegate = self;
    [self.native load];
}

-(void)nativeDidFinishLoading:(IMNative*)native
{
    NSError *error;
    NSData *data = [native.adContent dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *imobiDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    AdsMogoNativeAdInfo *adsMogoNativeInfo =[[AdsMogoNativeAdInfo alloc]init];
    [adsMogoNativeInfo setValue:[imobiDict objectForKey:@"title"] forKey:AdsMoGoNativeMoGoTitle];
    [adsMogoNativeInfo setValue:[[imobiDict objectForKey:@"icon"] objectForKey:@"url"] forKey:AdsMoGoNativeMoGoIconUrl];
    [adsMogoNativeInfo setValue:[[imobiDict objectForKey:@"icon"] objectForKey:@"width"] forKey:AdsMoGoNativeMoGoIconWidth];
    [adsMogoNativeInfo setValue:[[imobiDict objectForKey:@"icon"] objectForKey:@"height"] forKey:AdsMoGoNativeMoGoIconHeight];
    [adsMogoNativeInfo setValue:[imobiDict objectForKey:@"description"] forKey:AdsMoGoNativeMoGoDesc];
    [adsMogoNativeInfo setValue:[[imobiDict objectForKey:@"screenshots"] objectForKey:@"url"] forKey:AdsMoGoNativeMoGoImageUrl];
    [adsMogoNativeInfo setValue:[[imobiDict objectForKey:@"screenshots"] objectForKey:@"width"] forKey:AdsMoGoNativeMoGoImageWidth];
    [adsMogoNativeInfo setValue:[[imobiDict objectForKey:@"screenshots"] objectForKey:@"height"] forKey:AdsMoGoNativeMoGoImageHeight];
    
    
    [adsMogoNativeInfo setValue:imobiDict forKey:AdsMoGoNativeMoGoPdata];
    [adsMogoNativeInfo setValue:[self getMogoJsonByDic:adsMogoNativeInfo] forKey:AdsMoGoNativeMoGoJsonStr];
    [mutableArray addObject:adsMogoNativeInfo];
    [adsMogoNativeInfo release];
    [self adMoGoNativeCustom:self didReceiveAd:mutableArray];
}

-(void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error
{
//    [self adMogoNativeFailAd:-1];
    [self adMoGoNativeCustom:self didFail:-1];
}

- (NSDictionary*)dictFromNativeContent:(NSString*)nativeContent
{
    if (nativeContent == nil) {
        return nil;
    }
    NSData* data = [nativeContent dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableDictionary* nativeJsonDict = [NSMutableDictionary dictionaryWithDictionary:jsonDict];
    return nativeJsonDict;
}


//展示广告
-(void)attachAdView:(UIView*)view nativeData:(AdsMogoNativeAdInfo*)info
{
    [super attachAdView:view nativeData:info];
    [IMNative bindNative:self.native toView:view];
}

//点击广告
- (void)clickAd:(AdsMogoNativeAdInfo*)info
{
    [super clickAd:info];
    NSDictionary *dict = [info valueForKey:AdsMoGoNativeMoGoPdata];
    NSString *url = [dict valueForKey:@"landingURL"];
    NSURL* URL = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:URL];
    [self.native reportAdClick:nil];
}

//停止请求广告
- (void)stopAd
{
}

//请求广告超时
- (void)loadAdTimeOut:(NSTimer*)theTimer
{
    [super loadAdTimeOut:theTimer];
//    [self adMogoNativeFailAd:-1];
    
    [self adMoGoNativeCustom:self didFail:-1];
}

- (void)dealloc
{
    if (_native) {
        [_native release],_native =nil;
    }
    [super dealloc];    
}

@end
