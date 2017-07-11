//
//  CallViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "CallViewController.h"

@interface CallViewController ()<UIWebViewDelegate>
@property(nonatomic,retain)UIWebView* webView;
@end

@implementation CallViewController
@synthesize webView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self settt:@"呼叫"];
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:webView];
    //加载百度 创建百度的url链接     网址链接
    NSURL* url=[NSURL URLWithString:@"http://api.cy.daoyoudao.com/app/getcalllist.do?groupid=10986&shopid=11814&industry=re&systype=ios&clientid=201406022338385212253"];  //这个不是安全的
    //请求    创建URL的请求
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    //让webView加载请求
    webView.delegate=self;
    [webView loadRequest:request];
    
}

@end
