//
//  FeedAdViewController.m
//  AdsMoGoSample
//
//  Created by mogo on 13-12-20.
//  Copyright (c) 2013年 MOGO. All rights reserved.
//

#import "FeedAdViewController.h"
#import "AdsMoGoNative.h"
#import "AdsMogoNativeAdInfo.h"
#import "AdsMogoNativeCell.h"
#import "AdsMogoNativeAdInfo.h"
#import "MBProgressHUD.h"
@interface FeedAdViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate> {
    UITableView *  nativeTable;
    NSMutableArray  *nativeArray;
    BOOL isLoading;
    MBProgressHUD * hudProgress;
}

@end

@implementation FeedAdViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nativeTable =[[UITableView alloc]initWithFrame:CGRectMake(0,44,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStylePlain];
    nativeTable.delegate=self;
    nativeTable.dataSource=self;
    [self.view addSubview:nativeTable];
    [nativeTable release];
    
    [self createNative];
    AdsMoGoNative *adsMoGoNative = [AdsMoGoNative shareInstance];
    [adsMoGoNative loadAd];
    
    hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
    
    hudProgress.delegate = self;
    hudProgress.labelText = @"正在加载中...";
    [hudProgress show:YES];
    [self.view addSubview:hudProgress];
    [hudProgress release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    nativeTable.delegate = nil;
    
    nativeTable.dataSource=nil;
    
    AdsMoGoNative *adsMoGoNative = [AdsMoGoNative shareInstance];
    adsMoGoNative.delegate = nil;
    hudProgress.delegate = nil;
    
    [super dealloc];
}

- (void)createButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"getAd" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(id)sender
{
    
}

- (void)createNative
{
    AdsMoGoNative *adsMoGoNative = [AdsMoGoNative shareInstance];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        [adsMoGoNative initWithMoGoID:MoGo_ID_IPhone withDelegate:self withNativeType:AdNativeTypeiPhone];
    } else {
        [adsMoGoNative initWithMoGoID:MoGo_ID_IPad withDelegate:self withNativeType:AdNativeTypeiPad];
    }
}

- (void)requestNativeAdSuccess:(NSArray *)adsmogonativeadlist
{
    isLoading=NO;
    if (!nativeArray) {
        nativeArray =[[NSMutableArray alloc]initWithArray:adsmogonativeadlist];
    } else {
        [nativeArray addObjectsFromArray:adsmogonativeadlist];
    }
    
    [nativeTable reloadData];
    
    [hudProgress hide:YES];
    
    NSLog(@"requestNativeAdSuccess:%@",adsmogonativeadlist);
}

- (void)requestNativeAdFail:(int) errorCode
{
    isLoading=NO;
    [hudProgress hide:YES];
    NSLog(@"requestNativeAdFail");
}

#pragma mark --Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (nativeArray) {
        return [nativeArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdsMogoNativeAdInfo * info =[nativeArray objectAtIndex:[indexPath row]];
    AdsMogoNativeCell * cell =[[AdsMogoNativeCell alloc]loadNativeView:self.view.frame info:info.context_dic];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [info attachAdView:cell];
    });
    return cell;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdsMogoNativeAdInfo * info =[nativeArray objectAtIndex:[indexPath row]];
    if ([info.context_dic objectForKey:AdsMoGoNativeMoGoLinkUrl]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[info.context_dic objectForKey:AdsMoGoNativeMoGoLinkUrl]]];
        [info clickAd];
    } else {
        [info clickAd];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 假设偏移表格高度的20%进行刷新
    if (!isLoading) {
        float height = scrollView.contentSize.height > nativeTable.frame.size.height ?nativeTable.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            // 调用上拉刷新方法
            isLoading=YES;
            AdsMoGoNative *adsMoGoNative = [AdsMoGoNative shareInstance];
            [adsMoGoNative loadAd];
            [hudProgress show:YES];
        }
        //        if (- scrollView.contentOffset.y / nativeTable.frame.size.height > 0.2) {
        //            // 调用下拉刷新方法
        //        }
    }
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

@end
