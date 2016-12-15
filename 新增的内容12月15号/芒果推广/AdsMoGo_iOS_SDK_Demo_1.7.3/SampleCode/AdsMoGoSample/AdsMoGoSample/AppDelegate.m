//
//  AppDelegate.m
//  AdsMoGoSample
//
//  Created by MOGO on 13-11-21.
//  Copyright (c) 2013年 MOGO. All rights reserved.
//

#import "AppDelegate.h"
#import "AdTypeListViewController.h"
#import "AdMoGoLogCenter.h"
#import "AdsMOGOContent.h"

@interface AppDelegate()

@property (nonatomic, retain) AdMoGoSplashAds *splash;

@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    AdTypeListViewController *adtypeList = [[AdTypeListViewController alloc] initWithStyle:UITableViewStylePlain];
    navigationController = [[MyNavigationController alloc] initWithRootViewController:adtypeList];
    [adtypeList release];
    
    // 将下面代码 [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogTemp] 取消注释可以看到芒果日志输出
    
    //    [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogTemp];
    //    [[AdMoGoLogCenter shareInstance] setLogLeveFlag:AdMoGoLogDebug];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;
    [navigationController release];
    [self.window makeKeyAndVisible];
    
    [AdsMOGOContent shareSingleton].title = @"开屏";
    [AdsMOGOContent shareSingleton].url = @"https://www.baidu.com";
    [[AdsMOGOContent shareSingleton] setCatType:CatTypeVideoParent_Child,CatTypeNewsEncyclopedia,CatTypeListenBookLiterature,CatTypeBookChineseClassics,nil];
    [[AdsMOGOContent shareSingleton]setkeyWords:@"男性",@"手表",@"iPhone",nil];
    
    //这里需要注意，要强引用开屏对象，要不然开屏对象在出了函数作用域会被释放掉，导致无法展示
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        self.splash = [[[AdMoGoSplashAds alloc] initWithAppKey:MoGo_ID_IPad
                                       adMoGoSplashAdsDelegate:self
                                                        window:self.window] autorelease];
    } else {
        self.splash = [[[AdMoGoSplashAds alloc] initWithAppKey:MoGo_ID_IPhone
                                       adMoGoSplashAdsDelegate:self
                                                        window:self.window] autorelease];
    }
    [self.splash requestSplashAd];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController *)adsMoGoSplashAdsViewControllerForPresentingModalView{
    return navigationController;
}


// 开屏获取背景图 这个回调一定要实现
- (NSString *)adsMoGoSplashAdsiPhoneImage{
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    NSInteger height = [UIScreen mainScreen].bounds.size.height;
    if (width == 320 && height <= 480) {
        // iphone4 iphone4s 上的default图片
        return @"Default";
    } else if (width == 320 && height == 568) {
        // iphone5 上的default图片
        return @"Default-568h";
    } else if (width == 375) {
        // iphone6 上的default图片
        return @"Default-375w-667h";
    } else if (width == 414) {
        // iphone6 plus 上的default图片
        return @"Default-736h";
    } else {
        return  NULL;
    }
}

- (NSString *)adsMoGoSplashAdsiPadLandscapeImage
{
    return @"Default-Landscape";
}

- (NSString *)adsMoGoSplashAdsiPadPortraitImage
{
    return @"Default-Portrait";
}

- (void)adsMoGoSplashAdsSuccess:(AdMoGoSplashAds *)splashAds
{
    NSLog(@"AdsMoGoSplashAds Success");
}

- (void)adsMoGoSplashAdsFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err
{
    NSLog(@"AdsMoGoSplashAds fail %@",err);
}

- (void)adsMoGoSplashAdsAllAdFail:(AdMoGoSplashAds *)splashAds withError:(NSError *)err
{
    NSLog(@"AdsMoGoSplashAdsAllAd fail %@",err);
}

- (void)adsMoGoSplashAdsFinish:(AdMoGoSplashAds *)splashAds
{
    NSLog(@"AdsMoGoSplashAdsAllAd Finish");
}

- (void)adsMoGoSplashAdsWillPresent:(AdMoGoSplashAds *)splashAds
{
    NSLog(@"AdsMoGoSplashAdsAllAd will Present");
}

- (void)adsMoGoSplashAdsDidPresent:(AdMoGoSplashAds *)splashAds
{
    NSLog(@"AdsMoGoSplashAdsAllAd did present");
}

- (void)adsMoGoSplashAdsWillDismiss:(AdMoGoSplashAds *)splashAds
{
    NSLog(@"AdsMoGoSplashAdsAllAd will dismiss");
}

- (void)adsMoGoSplashAdsDidDismiss:(AdMoGoSplashAds *)splashAds
{
    NSLog(@"AdsMoGoSplashAdsAllAd did dismiss");
}

/*
 返回芒果自售广告尺寸
 */
//- (CGRect)adMoGoSplashAdSize{
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//
//
//    float w = 300.0f;
//    float h = 300.0f;
//
//    float x = (screenSize.width - w) / 2;
//    float y = (screenSize.height - h) /2;
//
//    return  CGRectMake(x, y, w, h);
//}

// 仅在芒果自售广告中使用
//ipad 屏幕适配 (旋转相关)
//设备旋转 需更换开屏广告的default图片
- (NSString *)adsMoGoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetImageName:(UIInterfaceOrientation)interfaceOri
{
    return [self getCurDefaultName];
}

// 仅在芒果自售广告中使用
//如果已展示广告旋转的过程需要调整广告的位置
- (CGPoint)adsMogoSplash:(AdMoGoSplashAds *)splashAd OrientationDidChangeGetAdPoint:(UIInterfaceOrientation)interfaceOri
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float w =320, h = 480, x = 0, y = 0;
    if (interfaceOri == UIInterfaceOrientationPortrait || interfaceOri == UIInterfaceOrientationPortraitUpsideDown) {
        x = (screenSize.width - w) / 2;
        y = (screenSize.height - h) /2;
    } else {
        x = (screenSize.height - w) / 2;
        y = (screenSize.width - h) /2;
    }
    return CGPointMake(x, y);
}

- (NSString *)getCurDefaultName
{
    BOOL _isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    NSString *name = @"Default";
    int scale = [UIScreen mainScreen].scale;
    if (!_isPad) {
        if (scale > 1 ) {
            if ([UIScreen mainScreen].bounds.size.height > 480) {
                name = @"Default-568h@2x";
            } else {
                name = @"Default@2x";
            }
        } else {
            name = @"Default";
        }
    } else {
        UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
        if (scale > 1) {
            if (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) {
                name = @"Default-Portrait@2x";
            }else{
                name = @"Default-Landscape@2x";
            }
        } else {
            if (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) {
                name = @"Default-Portrait";
            }else{
                name = @"Default-Landscape";
            }
        }
        
    }
    return name;
}

//返回芒果开屏显示类型 1 全屏 2居上 3居下
- (SplashAdShowType)adMoGoSplashShowType
{
    return SplashAdShowTypeFull;
}


@end
