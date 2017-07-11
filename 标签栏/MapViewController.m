//
//  MapViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<UIWebViewDelegate>
@property(nonatomic,retain)UIWebView* webView;
@end

@implementation MapViewController
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    [self settt:self.title];
    
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:webView];
    //加载百度 创建百度的url链接     网址链接
    NSURL* url=[NSURL URLWithString:@"http://map.baidu.com/?newmap=1&ie=utf-8&s=s%26wd%3Dwww"];
    //请求    创建URL的请求
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    //让webView加载请求
    webView.delegate=self;
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

