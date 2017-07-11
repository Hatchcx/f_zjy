//
//  RootViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//
#import "RootViewController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "MapViewController.h"
#import "CallViewController.h"
#import "MoreViewController.h"

@interface RootViewController ()
@property(retain)NSArray* arr2;
@property(retain)UIView* smallview;
@end
@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr2=@[@"菜单",@"醉江月",@"地图",@"呼叫",@"更多"];
    
    self.view.backgroundColor=[UIColor whiteColor];//背景颜色为白色
    self.tabBar.hidden=YES;//隐藏掉之前的tabbar
    //self.navigationController.navigationBarHidden=YES;//隐藏掉导航栏  自己写
    [self crearBtn];//自己创建5个按钮
    [self crearNav];
    self.selectedIndex=1;
    //    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    //_smallview=[[UIView alloc]initWithFrame:CGRectMake(width/5,0,width/5,2)];
    //    _smallview.backgroundColor=[UIColor orangeColor];
    //    [_backview addSubview:_smallview];
    
    // Do any additional setup after loading the view.
}
-(void)crearBtn
{
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    _backview=[[UIImageView alloc]initWithFrame:CGRectMake(0,height-49, width, 49)];//底部的高度
    _backview.userInteractionEnabled=YES;//可以第几
    _backview.backgroundColor=[UIColor colorWithRed:0/255.0 green:1/255.0 blue:2/255.0 alpha:1];
    [self.view addSubview:_backview];
    
    
    for(int i=0;i<5;i++)//创建5个uiview
    {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(width/5*i,0, width/5, 49);//高度为49和哪个一样
        //设置图片
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tool%d.1",i+1]] forState:UIControlStateNormal];//设置图片的颜色
        //设置被点击后的颜色
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tool%d",i+1]] forState:UIControlStateSelected];
        
        
        [btn addTarget:self action:@selector(btnActiond:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=20+i;
        
        //设置位置中间
        //        UILabel* laber=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x,37,width/5, 5)];
        //            laber.font=[UIFont systemFontOfSize:10];
        //        laber.text=_arr2[i];
        //        laber.textColor=[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
        //        laber.textAlignment=1;
        //        laber.tag=10+i;
        //
        if(i==1)
        {
            btn.selected=YES;
            //            laber.textColor=[UIColor whiteColor];//白色选中颜色
        }
        [_backview addSubview:btn];
        
        
        //        [_backview addSubview:laber];//添加
    }
    
    
    
}
-(void)btnActiond:(UIButton*)sender
{
    
    
    NSArray* arr=_backview.subviews;
    for(UIView* tempview in arr)
    {
        if([tempview isMemberOfClass:[UIButton class]])
        {
            UIButton* btn=(UIButton*)tempview;
            //                UILabel* laber=[_backview viewWithTag:btn.tag-10];
            if(sender.tag!=btn.tag)
            {
                btn.selected=NO;
                //                    laber.textColor=[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
            }else
            {
                btn.selected=YES;
                //                    laber.textColor=[UIColor whiteColor];
                //                    _smallview.frame=CGRectMake(btn.frame.origin.x,0,sender.frame.size.width,2);
            }
        }
    }
    self.selectedIndex=sender.tag-20;
    
}
-(void)crearNav
{
    MenuViewController* view=[[MenuViewController alloc]init];
    HomeViewController* view1=[[HomeViewController alloc]init];
    MapViewController* view2=[[MapViewController alloc]init];
    CallViewController* view3=[[CallViewController alloc]init];
    MoreViewController* view4=[[MoreViewController alloc]init];
    NSArray* arr=@[view,view1,view2,view3,view4];
    NSMutableArray* arr1=[NSMutableArray new];
    for(int i=0;i<arr.count;i++)
    {
        UIViewController* v=arr[i];
        v.title=_arr2[i];//设置导航条的字
        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:arr[i]];
        [arr1 addObject:nav];
    }
    self.viewControllers=arr1;
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
