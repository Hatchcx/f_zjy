//
//  HomeViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "HomeViewController.h"
#import "Buy1ViewController.h"
#import "UIImageView+WebCache.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import "DataRequest.h"
#import "LeftViewController.h"

#define kHomeUrlString  @"http://api.cy.daoyoudao.com//app/getgglist.do?groupid=10986&systype=ios&shopid=11814&clientid=201406022338385212253"

@interface HomeViewController ()<UIScrollViewDelegate>
@property (retain)UIScrollView *scorllView;
@property (retain)UIPageControl *page;
@property(retain)NSArray* laberName;
@property(retain)NSTimer* timer;
@property(assign)BOOL isfo;
@property(retain)NSMutableArray* app;
@property(retain)Buy1ViewController* homehome;
@end

@implementation HomeViewController

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
    [self downData];
    _app = [[NSMutableArray alloc]init];
    //设置
    [self bulieNav:self.title andleftimagename:@"nav1.png" andrightmagename:@"nav2.png"];
    _laberName=@[@"精品凉菜",@"经典川湘",@"金牌菜肴",@"甜品主食",@"新派粤菜"];
    //scorllview 和page
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    
    _scorllView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,width,(height-64)/3)];
    
    UIView* views=[[UIView alloc]initWithFrame:CGRectMake(0,_scorllView.frame.origin.y+_scorllView.frame.size.height-30,width,30)];
    views.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _page=[[UIPageControl alloc]initWithFrame:CGRectMake(width-100,0,100,30)];
    _page.numberOfPages=3;
    [_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [views addSubview:_page];
    //scorllview的3张图片
    for(int i=0;i<3;i++)
    {
        //scrollView加载三张图片
        UIImageView* image=[[UIImageView alloc]initWithFrame:CGRectMake(0+i*[UIScreen mainScreen].bounds.size.width,0,[UIScreen mainScreen].bounds.size.width,_scorllView.frame.size.height)];//高度是_scrllview的高度
        image.image=[UIImage imageNamed:@"star_gray.png"];//设置图片的名字是
        image.tag=40+i;
        [_scorllView addSubview:image];
        
    }
    //设置_scorllView可以滑动
    _scorllView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*3,0);
    _scorllView.bounces=NO;
    _scorllView.showsHorizontalScrollIndicator=NO;
    _scorllView.pagingEnabled=YES;
    
    CGFloat heighty=(height-154-_scorllView.frame.size.height)/2;
    CGFloat heightx=_scorllView.frame.size.height+74;
    //2张大的图片
    for(int i=0;i<2;i++)//图片的位置
    {
        
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(20,heightx+i*(heighty+20),heighty,heighty)];
        [self.view addSubview:btn];
        btn.tag=10+i;//
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*laber=[[UILabel alloc]initWithFrame:CGRectMake(0, btn.frame.size.height-30,btn.frame.size.width, 30)];
        laber.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        laber.textColor=[UIColor whiteColor];
        laber.text=_laberName[i];
        UIImageView* image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,heighty,heighty)];
        image.tag=10;
        image.image=[UIImage imageNamed:@"star_gray.png"];
        [btn addSubview:image];
        [btn addSubview:laber];
        
    }
    //3张小的图片
    for(int i=0;i<3;i++)
    {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(20+heighty+20,heightx+i*((heighty*2-10)/3+10),width-60-heighty,heighty*2/3)];
        [self.view addSubview:btn];
        btn.tag=20+i;//
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel*laber=[[UILabel alloc]initWithFrame:CGRectMake(0, btn.frame.size.height-30,btn.frame.size.width, 30)];
        laber.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        laber.text=_laberName[2+i];
        laber.textColor=[UIColor whiteColor];
        
        UIImageView* image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width-60-heighty,heighty*2/3)];
        image.tag=10;
        [btn addSubview:image];
        [btn addSubview:laber];
    }
    _scorllView.delegate=self;
    _page.currentPage=0;
    [self.view addSubview:_scorllView];
    [self.view addSubview:views];
    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(run) userInfo:nil repeats:YES];
}
-(void)downData//下载数据
{
    [DataRequest getUrlStr:kHomeUrlString finish:^(id dataString) {  //数据加载后
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
        NSDictionary* dic1=[dic objectForKey:@"getgglist"];//获取到这个
        [_app addObjectsFromArray:[dic1 objectForKey:@"xiaotu"]];
        NSArray* app1=[dic1 objectForKey:@"lunbo"];

        for(int i=0;i<3;i++)
        {
            UIImageView* im=[self.view viewWithTag:40+i];//获取每个btn对应到imagview
            [im setImageWithURL:[NSURL URLWithString:[app1[i] objectForKey:@"showpic"]] placeholderImage:[UIImage imageNamed:@"AddDish"]];
        }
        for(int i=0;i<2;i++)//获取2张图片
        {
            UIButton* btn=[self.view viewWithTag:10+i];//获取到btn
            UIImageView* im=[btn viewWithTag:10];//获取每个btn对应到imagview
            [im setImageWithURL:[NSURL URLWithString:[_app[i] objectForKey:@"showpic"]] placeholderImage:[UIImage imageNamed:@"AddDish"]];
        }
        
        for(int i=0;i<3;i++)
        {
            UIButton* btn=[self.view viewWithTag:20+i];
            UIImageView* im=[btn viewWithTag:10];//获取每个btn对应到imagview
            [im setImageWithURL:[NSURL URLWithString:[_app[2+i] objectForKey:@"showpic"]] placeholderImage:[UIImage imageNamed:@"AddDish"]];
        }
    } andError:^(NSError *error) {
        
    }];//请求到数据才赋值
    
}
-(void)btnAction:(UIButton*)sender
{
    switch (sender.tag) {  //大图
        case 10:
            _homehome = [[Buy1ViewController alloc]init];
            _homehome.name=_laberName[0];
            _homehome.page=0;
            _homehome.str = [_app[0] objectForKey:@"tid"];
            NSLog(@"%@", _homehome.str);
            break;
        case 11:
            _homehome = [[Buy1ViewController alloc]init];
            _homehome.page=1;
            _homehome.name=_laberName[1];
            _homehome.str = [_app[1] objectForKey:@"tid"];
            NSLog(@"%@", _homehome.str);
            break;
        case 20:
            _homehome = [[Buy1ViewController alloc]init];
            _homehome.page=2;
            _homehome.name=_laberName[2];
            _homehome.str = [_app[2] objectForKey:@"tid"];
            NSLog(@"%@", _homehome.str);
            break;
        case 21:
            _homehome = [[Buy1ViewController alloc]init];
            _homehome.page=3;
            _homehome.name=_laberName[3];
            _homehome.str = [_app[3] objectForKey:@"tid"];
            NSLog(@"%@", _homehome.str);
            break;
        case 22:
            _homehome = [[Buy1ViewController alloc]init];
            _homehome.page=4;
            _homehome.name=_laberName[4];
            _homehome.str = [_app[4] objectForKey:@"tid"];
            NSLog(@"%@", _homehome.str);
            break;
        default:
            break;
    }
    //进入第购买页面
    [self.navigationController pushViewController:_homehome animated:YES];
    
}
-(void)run
{
    if(_page.currentPage==0)
    {
        _isfo=!_isfo;//当为0的时候加加
    }else if(_page.currentPage==2)
    {
        _isfo=!_isfo;//为假
    }
    if(_isfo)
    {
        _page.currentPage++;
        [UIView animateWithDuration:0.5 animations:^{
            _scorllView.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width*_page.currentPage,0);
        }];
    }else
    {
        _page.currentPage--;
        [UIView animateWithDuration:0.5 animations:^{
            _scorllView.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width*_page.currentPage,0);
        }];
    }
    
}
//点击page改变
- (void)pageAction:(UIPageControl *)sender//点击page进行改变的位置
{
    [UIView animateWithDuration:0.5 animations:^{
        _scorllView.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width*sender.currentPage,0);
    }];
}

#pragma UIScreenViewDelegate -make
- (void)scrollViewDidScroll:(UIScrollView *)scrollView //正在移动的时候调用这个
{
    CGPoint point=scrollView.contentOffset;
    NSInteger page=point.x/[UIScreen mainScreen].bounds.size.width;
    _page.currentPage=page;
    
}
-(void)leftAction:(UIButton*)sender
{
    
    UIApplication* app=[UIApplication sharedApplication];
    AppDelegate* dele=(AppDelegate*)app.delegate;
    RootViewController* root=(RootViewController*)dele.window.rootViewController;
    root.backview.hidden=YES;
    
    [self.navigationController pushViewController:[LeftViewController alloc] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

