//
//  AdTypeListViewController.m
//  AdsMoGoSample
//
//  Created by mogo on 13-11-21.
//  Copyright (c) 2013年 MOGO. All rights reserved.
//

#import "AdTypeListViewController.h"
#import "FullAdViewController.h"
#import "BannerAdViewController.h"
#import "iPadNormalBannerAdViewController.h"
#import "RectangleAdViewController.h"
#import "MediumBannerAdViewController.h"
#import "LargerBannerAdViewController.h"
#import "FeedAdViewController.h"
#import "ChecOutViewController.h"
#import "FullAdManualFreshViewController.h"
#import "iPhoneRectangleViewController.h"
#import "BannerAdManualFreshViewController.h"
#import "CustomerSizeViewController.h"
@interface AdTypeListViewController ()
{
    NSArray *typeListArray;
    NSUInteger totalNum;
}
@end

@implementation AdTypeListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            typeListArray = [[NSArray alloc] initWithObjects:@"AdViewTypeLargeBanner",@"AdViewTypeMediumBanner",@"AdViewTypeRectangle",@"AdViewTypeiPadNormalBanner",@"AdViewTypeiPadFullScreen",@"FeedAdViewController",@"ChecOutViewController",@"BannerAdManualFreshViewController",@"FullAdManualFreshViewController",@"CustomerSizeViewController",@"AdViewTypeIpadVideo",nil];
        } else {
            typeListArray = [[NSArray alloc] initWithObjects:@"AdViewTypeNormalBanner",@"iPhoneRectangleViewController",@"AdViewTypeFullScreen",@"FeedAdViewController",@"ChecOutViewController",@"BannerAdManualFreshViewController",@"FullAdManualFreshViewController",@"CustomerSizeViewController",@"AdViewTypeVideo",nil];
            
        }
        totalNum = [typeListArray count];
        self.title = AdMoGoVersion;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [typeListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==NULL) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row < totalNum) {
        cell.textLabel.text = [typeListArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < totalNum) {
        NSString *str = [typeListArray objectAtIndex:indexPath.row];
        if ([str isEqualToString:@"AdViewTypeNormalBanner"]) {
            BannerAdViewController *banner = [[BannerAdViewController alloc] init];
            banner.title = @"AdViewTypeNormalBanner";
            [self.navigationController pushViewController:banner animated:YES];
            [banner release];
        } else if ([str isEqualToString:@"AdViewTypeFullScreen"]) {
            FullAdViewController *full = [[FullAdViewController alloc] init];
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
                full.appkey = MoGo_ID_IPad;
            } else {
                full.appkey = MoGo_ID_IPhone;
            }
            
            full.title = @"AdViewTypeFullScreen";
            [self.navigationController pushViewController:full animated:YES];
            [full release];
        } else if ([str isEqualToString:@"AdViewTypeVideo"]) {
            FullAdViewController *full = [[FullAdViewController alloc] init];
            full.appkey = MoGo_ID_IPhone;
            full.title = @"AdViewTypeFullScreen";
            full.isVideo =YES;
            [self.navigationController pushViewController:full animated:YES];
            [full release];
        } else if ([str isEqualToString:@"AdViewTypeIpadVideo"]) {
            FullAdViewController *full = [[FullAdViewController alloc] init];
            full.appkey = MoGo_ID_IPad;
            full.title = @"AdViewTypeFullScreen";
            full.isVideo =YES;
            [self.navigationController pushViewController:full animated:YES];
            [full release];
        } else if ([str isEqualToString:@"AdViewTypeLargeBanner"]) {
            LargerBannerAdViewController *larger = [[LargerBannerAdViewController alloc] init];
            larger.title = @"AdViewTypeLargeBanner";
            [self.navigationController pushViewController:larger animated:YES];
            [larger release];
        } else if ([str isEqualToString:@"AdViewTypeMediumBanner"]) {
            MediumBannerAdViewController *medium = [[MediumBannerAdViewController alloc] init];
            medium.title= @"AdViewTypeMediumBanner";
            [self.navigationController pushViewController:medium animated:YES];
            [medium release];
        } else if ([str isEqualToString:@"AdViewTypeRectangle"]) {
            RectangleAdViewController *rect = [[RectangleAdViewController alloc] init];
            rect.title = @"AdViewTypeRectangle";
            [self.navigationController pushViewController:rect animated:YES];
            [rect release];
        } else if ([str isEqualToString:@"AdViewTypeiPadNormalBanner"]) {
            iPadNormalBannerAdViewController *ipadNormalBanner = [[iPadNormalBannerAdViewController alloc] init];
            ipadNormalBanner.title = @"AdViewTypeiPadNormalBanner";
            [self.navigationController pushViewController:ipadNormalBanner animated:YES];
            [ipadNormalBanner release];
        } else if ([str isEqualToString:@"AdViewTypeiPadFullScreen"]) {
            FullAdViewController *full = [[FullAdViewController alloc] init];
            full.appkey = MoGo_ID_IPad;
            full.title = @"AdViewTypeiPadFullScreen";
            [self.navigationController pushViewController:full animated:YES];
            [full release];
        } else if([str isEqualToString:@"FeedAdViewController"]) {
            FeedAdViewController *ipadFullScreen = [[FeedAdViewController alloc] init];
            ipadFullScreen.title =@"FeedAdViewController";
            [self.navigationController pushViewController:ipadFullScreen animated:YES];
            [ipadFullScreen release];
        } else if([str isEqualToString:@"ChecOutViewController"]) {
            ChecOutViewController *checoutVC = [[ChecOutViewController alloc] init];
            checoutVC.title = @"updateVersion";
            [self.navigationController pushViewController:checoutVC animated:YES];
            [checoutVC release];
        } else if([str isEqualToString:@"iPhoneRectangleViewController"]) {
            iPhoneRectangleViewController *iPhoneRect = [[iPhoneRectangleViewController alloc] init];
            [self.navigationController pushViewController:iPhoneRect animated:YES];
            [iPhoneRect release];
        } else if([str isEqualToString:@"BannerAdManualFreshViewController"]) {
            BannerAdManualFreshViewController *bannerManualFreshVC = [[BannerAdManualFreshViewController alloc] init];
            [self.navigationController pushViewController:bannerManualFreshVC animated:YES];
            [bannerManualFreshVC release];
        } else if([str isEqualToString:@"FullAdManualFreshViewController"]) {
            FullAdManualFreshViewController *fulladmanualvc = [[FullAdManualFreshViewController alloc] init];
            [self.navigationController pushViewController:fulladmanualvc animated:YES];
            [fulladmanualvc release];
        } else if ([str isEqualToString:@"CustomerSizeViewController"]) {
            CustomerSizeViewController *customerSizevc = [[CustomerSizeViewController alloc] init];
            [self.navigationController pushViewController:customerSizevc animated:YES];
            [customerSizevc release];
        }
    }
}

@end
