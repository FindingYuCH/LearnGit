//
//  AdMoGoNativeAdapterInmobiCustomEvent.h
//  mogoNativeDemo
//
//  Created by MOGO on 15-5-6.
//  Copyright (c) 2015年 ___ADSMOGO___. All rights reserved.
//

#import "AdMoGoNativeAdapterCustomEvent.h"
#import "IMNative.h"

@interface AdMoGoNativeAdapterInmobiCustomEvent : AdMoGoNativeAdapterCustomEvent<IMNativeDelegate>

@property (nonatomic, retain) IMNative *native;

@end
