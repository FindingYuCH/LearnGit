//
//  AdsMogoNativeCell.h
//  test
//
//  Created by Castiel Chen on 15/1/8.
//  Copyright (c) 2015年 Castiel Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdsMogoNativeAdInfo.h"

@interface AdsMogoNativeCell : UITableViewCell

-(id)loadNativeView:(CGRect)rect info:(NSDictionary*)info;
@end
