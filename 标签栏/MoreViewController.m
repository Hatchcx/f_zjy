//
//  MoreViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "MoreViewController.h"
#import "IntroductionViewController.h"
#import "ContactViewController.h"
#import "FeedbackViewController.h"
#import "AppDelegate.h"
#import "RootViewController.h"

@interface MoreViewController ()
@property(retain)NSArray* dataSource;
@end

@implementation MoreViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];//即将出现的时候出现这个
    UIApplication* app=[UIApplication sharedApplication];
    AppDelegate* dele=(AppDelegate*)app.delegate;
    RootViewController* root=(RootViewController*)dele.window.rootViewController;
    root.backview.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settt:self.title];
    _dataSource=@[@"企业简介",@"联系我们",@"版本更新",@"设置",@"最近浏览",@"我的收藏",@"用户反馈",@"关于道有道",@"帮组手册",@"隐私保护",@"版权声明"];
    UIScrollView* scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,64,pmwidth,55*11+30)];
    scrollview.contentSize=CGSizeMake(0,55*11+30+80);
    if(pmwidth<414)
    {
        scrollview.contentSize=CGSizeMake(0,55*11+30+220);
    }
    scrollview.bounces=NO;
    scrollview.backgroundColor=[UIColor whiteColor];
    //让图片出现一张
    [self.view addSubview:scrollview];
    
    CGFloat viewx=pmwidth-40; //它的宽
    
    UIImageView* view=[[UIImageView alloc]initWithFrame:CGRectMake(20,20,viewx,55*3)];
    view.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=5;
    [scrollview addSubview:view];
    int a=1;
    for(int i=0;i<3;i++,a++)
    {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(1,i*55+1,viewx-2,55-1.5);
        btn.tag=a;
        
        [btn setTitle:_dataSource[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }

    UIImageView* view1=[[UIImageView alloc]initWithFrame:CGRectMake(20,40+55*3,viewx,55*4)];
    view1.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius=5;
    for(int i=0;i<4;i++,a++)
    {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(1,i*55+1,viewx-2,55-1.5);
        [btn setTitle:_dataSource[i+3] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn.tag=a;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [view1 addSubview:btn];
    }
    [scrollview addSubview:view1];//添加

    UIImageView* view2=[[UIImageView alloc]initWithFrame:CGRectMake(20,60+55*3+55*4,viewx,55*4)];
    view2.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    view2.layer.masksToBounds=YES;
    view2.layer.cornerRadius=5;
    for(int i=0;i<4;i++,a++)
    {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(1,i*55+1,viewx-2,55-1.5);
        [btn setTitle:_dataSource[i+7] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn.tag=a;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [view2 addSubview:btn];
    }
    view.userInteractionEnabled=YES;
    view1.userInteractionEnabled=YES;
    view2.userInteractionEnabled=YES;
    
    [scrollview addSubview:view2];//添加
}
-(void)btnAction:(UIButton*)sender
{
    NSLog(@"点击了%@",_dataSource[sender.tag-1]);
    //_dataSource=@[@"企业简介",@"联系我们",@"版本更新",@"设置",@"最近浏览",@"我的收藏",@"用户反馈",@"关于道有道",@"帮组手册",@"隐私保护",@"版权声明"];
    switch (sender.tag) {
        case 1:
            [self had];
            [self.navigationController pushViewController:[IntroductionViewController alloc] animated:YES];
            break;
        case 2:
            [self had];
            [self.navigationController pushViewController:[ContactViewController alloc] animated:YES];
            break;
        case 7:
            [self had];
            [self.navigationController pushViewController:[FeedbackViewController alloc] animated:YES];
            break;
        default:
            break;
    }
}
-(void)had
{
    UIApplication* app=[UIApplication sharedApplication];
    AppDelegate* dele=(AppDelegate*)app.delegate;
    RootViewController* root=(RootViewController*)dele.window.rootViewController;
    root.backview.hidden=YES;
    
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
