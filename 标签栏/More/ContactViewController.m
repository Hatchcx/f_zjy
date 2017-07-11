//
//  ContactViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "ContactViewController.h"
#import "DataRequest.h"  //数据请求
#import "UIImageView+WebCache.h"
#define PATH @"http://api.cy.daoyoudao.com/app/getCorpInfoList.do?groupid=10986&curpage=1&pagesize=10&clientid=201406022338385212253&infotypecode=4&versionrelease=ios_"
@interface ContactViewController ()
@property(nonatomic,retain)UIImageView* imageview;
@property(nonatomic,retain)UILabel* laber;
@property(nonnull,retain)UILabel* laber1;
@property(nonatomic,retain)UIButton* btn;
@end

@implementation ContactViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setleftbutton:nil andBackImageName:@"NO.png"];
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, pmwidth, pmheight)];
    [self.view addSubview:view];
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pmwidth, pmheight/3)];
    _imageview.backgroundColor=[UIColor redColor];
    _laber=[[UILabel alloc]initWithFrame:CGRectMake(20,pmheight/3+10, pmwidth-40,120)];
    _laber.numberOfLines=0;
    _laber.text=@"电话:";
    _btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame=CGRectMake(10,pmheight/3+40,pmwidth,60);
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIView* vie=[[UIView alloc]initWithFrame:CGRectMake(60,pmheight/3+80,pmwidth-100,1)];
    if(pmwidth>=414)
    {
        vie.frame=CGRectMake(110,pmheight/3+80,pmwidth-200,1);
    }
    vie.backgroundColor=[UIColor blueColor];
    
    _laber1=[[UILabel alloc]initWithFrame:CGRectMake(20,pmheight/3+30, pmwidth-40,120)];
    _laber1.numberOfLines=0;
    [view addSubview:vie];
    [view addSubview:_laber];
    [view addSubview:_laber1];
    [view addSubview:_imageview];
    [view addSubview:_btn];
    [self loaddata];//加载数据
    
    
}
-(void)btnAction
{
    NSLog(@"点击了电话");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settt:@"联系我们"];
}
-(void)loaddata
{
    [DataRequest getUrlStr:PATH finish:^(id dataString) {
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];//加载好数据后拿到数据
        NSArray* arr=[dic objectForKey:@"getCorpInfoList"];
        
        //        btn-- 02 什么的 _laber1是地址
        
        [_imageview setImageWithURL:[arr[0] objectForKey:@"showpic"] placeholderImage:[UIImage imageNamed:@"icon@2x.png"]];
        NSString*s =[arr[0] objectForKey:@"infomemo"];
        //电话：027-88060396&nbsp; 87292877
        NSArray* arr1=[s componentsSeparatedByString:@"<br />"];
        //
        NSString* s1=arr1[0];
        NSArray* arr2=[s1 componentsSeparatedByString:@"："];
        NSArray* arr3=[arr2[1] componentsSeparatedByString:@"&nbsp;"];
        [_btn setTitle:[NSString stringWithFormat:@"%@ %@",arr3[0],arr3[1]] forState:UIControlStateNormal];
        _laber1.text=arr1[1];
    } andError:^(NSError *error) {
        
    }];
    
    
}
-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
