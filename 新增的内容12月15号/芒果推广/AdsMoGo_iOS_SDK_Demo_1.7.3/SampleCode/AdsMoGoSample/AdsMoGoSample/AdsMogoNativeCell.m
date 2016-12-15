
//
//  AdsMogoNativeCell.m
//  test
//
//  Created by Castiel Chen on 15/1/8.
//  Copyright (c) 2015年 Castiel Chen. All rights reserved.
//

#import "AdsMogoNativeCell.h"

@interface AdsMogoNativeCell (){
    UIImageView * iconimage;
    UIImageView * con_image;
    NSMutableData * image_data;
    double  imagefileSize;
    
    UILabel * title;
    UILabel * desc;
    UILabel * adsource;
}

@end


@implementation AdsMogoNativeCell
- (id)loadNativeView:(CGRect)rect info:(NSDictionary*)info
{
    self=[super initWithFrame:rect];
    [info retain];
    if (self) {
        imagefileSize=0;
        UIView * nativeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width,300)];
        iconimage =[[UIImageView alloc]init];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[info objectForKey:AdsMoGoNativeMoGoIconUrl]]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                iconimage.image =iconImage;
                CALayer *roundedLayer = [iconimage layer];
                [roundedLayer setMasksToBounds:YES];
                roundedLayer.cornerRadius = iconimage.frame.size.width/2;
                iconimage.clipsToBounds=YES;
            });
        });
        iconimage.frame=CGRectMake(5, 5, 44, 44);
        [nativeView addSubview:iconimage];
        [iconimage release];
        
         title=[[UILabel alloc]initWithFrame:CGRectMake(iconimage.frame.origin.x+iconimage.frame.size.width+10, 5, rect.size.width-54,22)];
        title.text=[info objectForKey:AdsMoGoNativeMoGoTitle];
        title.textColor =[UIColor blueColor];
        title.font =[UIFont systemFontOfSize:12];
        [nativeView addSubview:title];
        [title release];
    
        
        desc =[[UILabel alloc]initWithFrame:CGRectMake(iconimage.frame.origin.x+iconimage.frame.size.width+10,(title.frame.origin.y+title.frame.size.height), rect.size.width-54,22)];
        desc.text=[info objectForKey:AdsMoGoNativeMoGoDesc];
        //    titile.textColor =[UIColor blueColor];
        desc.font =[UIFont systemFontOfSize:12];
        [nativeView addSubview:desc];
        [desc release];
        
        con_image =[[UIImageView alloc]init];
        con_image.frame =CGRectMake(10,(iconimage.frame.origin.x+iconimage.frame.size.height+10),self.frame.size.width-20,200);
        con_image.image=[UIImage imageNamed:@"loading.png"];
        [self loadImage:[info objectForKey:AdsMoGoNativeMoGoImageUrl] ];
         [nativeView addSubview:con_image];
        [con_image release];
        
        
         adsource=[[UILabel alloc]initWithFrame:CGRectMake(0,nativeView.frame.size.height-22, 100, 22)];
        adsource.text=[info objectForKey:AdsMoGoNativeMoGoPName];
        adsource.textColor =[UIColor grayColor];
        adsource.font =[UIFont systemFontOfSize:12];
        [nativeView addSubview:adsource];
        [adsource release];
        [[self contentView] addSubview:nativeView];
    }
        [info release];
    return self;
}

- (void)loadImage:(NSString*)image_url
{
    NSURL *url = [NSURL URLWithString:image_url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"]; //设置请求方式
    [request setTimeoutInterval:60];//设置超时时间
    image_data =[[NSMutableData alloc]init];
    [NSURLConnection connectionWithRequest:request delegate:self];//发送一个异步请求
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
        [image_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
        NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
        imagefileSize = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
    }//获取文件文件的大小
}

//数据加载完成后调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:image_data];
    con_image.image = image;
    con_image.frame=CGRectMake(10,(iconimage.frame.origin.x+iconimage.frame.size.height+10),self.frame.size.width-20,con_image.frame.size.height);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求网络失败:%@",error);
}

- (void)dealloc
{
    if (iconimage) {
        [iconimage release],iconimage =nil;
    }
    if (con_image) {
        [con_image release],con_image =nil;
    }
    
    if (image_data) {
        [image_data release],image_data=nil;
    }
    
    if (title) {
        [title release],title =nil;
    }
    if (desc) {
        [desc release],desc =nil;
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
