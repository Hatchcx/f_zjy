//
//  LeftViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "LeftViewController.h"
#define PATH @"http://api.cy.daoyoudao.com/app/categorylist.do?groupid=10986&shopid=12185&clientid=201406022338385212253&curpage=1&pagesize=50&versionrelease=ios_"
#import "SVProgressHUD.h"//菊花
#import "DataRequest.h"
#import "MJRefresh.h"   //上拉刷新 下拉加载
#import "AFNetworking.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray* dataSource;
@property(nonatomic,retain)UITableView* tableview;
@property(assign)BOOL isfo;
@end

@implementation LeftViewController
@synthesize tableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource=[NSMutableArray new];
    [self settt:@"菜品分类"];
    [self setleftbutton:nil andBackImageName:@"NO.png"];
    [self LoadDatad];
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64+55) style:UITableViewStylePlain];
    tableview.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0,0,pmwidth,60)];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
    
    // Do any additional setup after loading the view.
}
-(void)LoadDatad
{
    [DataRequest getUrlStr:PATH finish:^(id dataString) {
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];//加载好数据后拿到数据
        [_dataSource addObjectsFromArray:[dic objectForKey:@"categorylist"]];//添加到加载数据中
        [_dataSource addObjectsFromArray:[dic objectForKey:@"getDishList"]];//添加到加载数据中
        [tableview reloadData];
    } andError:^(NSError *error) {
        
    }];
}
#pragma UITableViewDelegate,UITableViewDataSource -make
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID=@"cell";
    UITableViewCell* cell=[tableview dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if(indexPath.row%2)
    {
        cell.backgroundColor=[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
    }else
    {
        cell.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    }
    cell.textLabel.text=[_dataSource[indexPath.row] objectForKey:@"categoryname"];
    //设置挂件
    cell.accessoryType=  UITableViewCellAccessoryDisclosureIndicator ;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了%@",[_dataSource[indexPath.row] objectForKey:@"categoryname"]);
}
-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)urlAction:(NSInteger)num
{
    
    
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
