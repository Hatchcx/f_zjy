//
//  ViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
#import "AppDelegate.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic)UIButton *jump;
@property(retain)UILabel* laber;
@property(retain)NSArray* TextArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _TextArr=@[@"醉江月紫阳湖",@"醉江月欢乐谷店",@"醉江月度假村"];
    
    for(int i=1;i<4;i++)
    {
        UIImageView* image=[[UIImageView alloc]initWithFrame:CGRectMake(0+(i-1)*[UIScreen mainScreen].bounds.size.width,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        image.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [_scrollview addSubview:image];
    }
    _scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*3, 0);
    _scrollview.bounces=NO;
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.pagingEnabled=YES;
    
    _jump=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-90,64,70,70)];
    _jump.layer.masksToBounds=YES;
    _jump.layer.cornerRadius=35;
    [_jump setBackgroundImage:[UIImage imageNamed:@"tiaoguo"] forState:UIControlStateNormal];
    [_jump addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    
    _laber=[[UILabel alloc]initWithFrame:CGRectMake(0,height/5*4,width, height/5)];
    _laber.font=[UIFont systemFontOfSize:25];
    _laber.text=_TextArr[0];
    _laber.textColor=[UIColor whiteColor];
    _laber.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:_laber];
    
    [self.view addSubview:_jump];
    _scrollview.delegate=self;
}
- (void)btnAction:(UIButton*)sender//当点击跳过的时候
{
    UIApplication* app=[UIApplication sharedApplication];
    AppDelegate* delegate=(AppDelegate*)app.delegate;
    delegate.window.rootViewController=nil;
    RootViewController* home=[[RootViewController alloc]init];
    delegate.window.rootViewController =home;
}
#pragma UIScreenViewDelegate -make
- (void)scrollViewDidScroll:(UIScrollView *)scrollView //正在移动的时候调用这个
{
    CGPoint point=scrollView.contentOffset;
    NSInteger page=point.x/[UIScreen mainScreen].bounds.size.width;
    _laber.text=_TextArr[page];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
