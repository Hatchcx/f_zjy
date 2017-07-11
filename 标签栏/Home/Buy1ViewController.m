//
//  Buy1ViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "Buy1ViewController.h"
#import "Buy2TableViewCell.h" //自定义cell
#import "MJRefresh.h"   //上拉刷新 下拉加载
#import "AppDelegate.h"//可以隐藏tabke
#import "RootViewController.h"
#import "SVProgressHUD.h"//菊花
#define PATH @"http://api.cy.daoyoudao.com/app/dishlist.do"
#import "DataRequest.h"  //数据请求
#import "UIImageView+WebCache.h"
@interface Buy1ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(retain)NSMutableArray* dataSource;//创建数据源
@property(retain)UITableView* tableview;
@property(retain)NSArray* arr;
@property(retain)UIImageView* cai;
@property(retain)UIImageView* monney;
@property(retain)UIImageView* paixu;
@property(retain)NSMutableDictionary* dataDic;
@property(assign)BOOL isfo;
@end

@implementation Buy1ViewController
@synthesize tableview;

-(void)viewWillAppear:(BOOL)animated    //视图控制器即将出现
{
    //有些数据需要重新更新
    //有些数据不需要每次都进行更新
    _isfo=false;
    _dataDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    NSArray* arr=@[@"全部",@"微咸",@"麻辣",@"香甜",@"酸辣",@"五香",@"酱香"];
    NSArray* arr1=@[@"全部价格",@"20元以下",@"20-50元",@"50-100元",@"100-200元",@"200元以上"];
    NSArray* arr2=@[@"按默认排序",@"按星级排序",@"按最热排序",@"按最新"];
    [self credeview];
    [self setcaic:arr andTag:100 andView:_cai];
    [self setcaic:arr1 andTag:150 andView:_monney];
    [self setcaic:arr2 andTag:200 andView:_paixu];
    
    
    [super viewWillAppear:YES];//ZfirstviewController 里是继承UIViewController
    UIApplication* app=[UIApplication sharedApplication];
    AppDelegate* dele=(AppDelegate*)app.delegate;
    RootViewController* root=(RootViewController*)dele.window.rootViewController;
    root.backview.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setleftbutton:nil andBackImageName:@"fnav.png"];
    [self setrightbutton:nil andBackImageName:@"fnav1.png"];
    [self settt:[NSString stringWithFormat:@"分类-%@",_name]];
    _dataSource=[NSMutableArray new];
    for(int i=0;i<4;i++)
    {
        [_dataSource addObject:[NSString stringWithFormat:@"%d.png",i+1]];
    }
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,pmwidth, pmheight-64) style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    //自定义一个tableviecell
    UIImageView* image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pmwidth, 50)];
    UIImageView* image1=[[UIImageView alloc]initWithFrame:CGRectMake(20,5,pmwidth-40,40)];
    UIImageView* image2=[[UIImageView alloc]initWithFrame:CGRectMake(5,5, pmwidth-50,30)];
    image.layer.masksToBounds=YES;
    image.layer.cornerRadius=3;
    image1.layer.masksToBounds=YES;
    image1.layer.cornerRadius=3;
    image2.layer.masksToBounds=YES;
    image2.layer.cornerRadius=3;
    image.userInteractionEnabled=YES;
    image1.userInteractionEnabled=YES;
    
    image2.userInteractionEnabled=YES;
    image.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:229/255.0 alpha:1];
    image1.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    image2.backgroundColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    
    [image addSubview:image1];

    CGFloat bx=(pmwidth-54-15)/3;
    NSArray* arr=@[@"全部口味",@"全部价格",@"按默认排序"];
    for(int i=0;i<3;i++)
    {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(2+i*(bx+5),2,bx,26 )];
        [btn setBackgroundImage:[UIImage imageNamed:@"tasteChoice.png"] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=10+i;
        [image2 addSubview:btn];
    }
    [image1 addSubview:image2];
    
    //头部视图
    tableview.tableHeaderView=image;
    
    
    
    static NSString* cellID=@"cell";
    //通过xib文件获取单元格,第一个参数是xib文件的文件名
    UINib* nib=[UINib nibWithNibName:@"Buy2TableViewCell" bundle:nil];
    //向表格注册单元格,第一个参数是单元格,第二个参数是单元格的标记
    [tableview registerNib:nib forCellReuseIdentifier:cellID];
    
    __weak __typeof(&*self)weakSelf =self;//self和Block代码块会一起产生强强应用 要改成弱应用
    [weakSelf urlAction:1];//一进入程序需要刷新一次
    [tableview addLegendHeaderWithRefreshingBlock:^{    //头部刷新
        [weakSelf.tableview.header beginRefreshing];
        [weakSelf urlAction:1];
    }];
    [tableview addLegendFooterWithRefreshingBlock:^{
        [weakSelf.tableview.footer beginRefreshing];
        [weakSelf urlAction:2];
    }];
}
-(void)btnAction:(UIButton*)btn
{
    switch (btn.tag) {
        case 10:
            _cai.hidden=NO;
            break;
        case 11:
            _monney.hidden=NO;
            break;
        case 12:
            _paixu.hidden=NO;
            break;
        default:
            break;
    }
    
}

#pragma UITableViewDelegate,UITableViewDataSource> -make

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //通过这个方法获取单元格时,如果存在走下面的代码.如果不存在系统会通过xib文件帮我们创建单元格,不需要我么创建
    static NSString* cellID=@"cell";
    
    Buy2TableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    // cell.bigImage.image=[UIImage imageNamed:_dataSource[indexPath.row]];
    //showpic
    
    [cell.bigImage setImageWithURL:[_dataSource[indexPath.row] objectForKey:@"showpic"] placeholderImage:[UIImage imageNamed:@"star_gray.png"]];
    cell.caiName.text=[_dataSource[indexPath.row] objectForKey:@"prodname"];//菜的名字
    int sum=[[_dataSource[indexPath.row] objectForKey:@"price"] intValue];//总价格
    
    cell.money.text=[NSString stringWithFormat:@"¥ %d.",sum];//第一个是整数价格
    cell.smalltext.text=[NSString stringWithFormat:@"00元/份"];
    cell.home=self;
    if(sum<100 && sum>10)
    {
        cell.smalltext.frame=CGRectMake(152,44, 500, 10);
    }else if(sum<10)
    {
        cell.smalltext.frame=CGRectMake(142,44, 500, 10);
    }else if(sum>=100)
    {
        cell.smalltext.frame=CGRectMake(160,44, 500, 10);
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//传的数组 和传入对应的tag值
-(void)setcaic:(NSArray*)arr andTag:(NSInteger)ta andView:(UIImageView*)cai
{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(pmwidth/4,pmwidth/2, pmwidth/2,40*7+30)];
    view.backgroundColor=[UIColor grayColor];
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=5;
    view.userInteractionEnabled=YES;
    UIView* view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, pmwidth/2,30)];//设置红色
    view1.backgroundColor=[UIColor redColor];//红色
    for(int i=0;i<arr.count;i++)
    {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0,30+i*30,pmwidth/2,29);
        btn.backgroundColor=[UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag=ta+i;
        [btn addTarget:self action:@selector(caiAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:btn];
    }
    [view addSubview:view1];//加红色标题
    [cai addSubview:view];
    [self.view addSubview:cai];
    cai.hidden=YES;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(void)caiAction:(UIButton*)sender//点击的是哪一个
{
    NSArray* arr=@[@"全部",@"微咸",@"麻辣",@"香甜",@"酸辣",@"五香",@"酱香"];
    NSArray* arr1=@[@"全部价格",@"20元以下",@"20-50元",@"50-100元",@"100-200元",@"200元以上"];
    NSArray* arr2=@[@"按默认排序",@"按星级排序",@"按最热排序",@"按最新"];
    [self hideview];
    for(int i=0;i<arr.count;i++)
    {
        if(sender.tag==(i+100))//如果是这个的话
        {
            NSLog(@"点击了%@",arr[i]);
            
            return;//跳出这个函数
        }
    }
    for(int i=0;i<arr1.count;i++)
    {
        if(sender.tag==(i+150))//如果是这个的话
        {
            NSLog(@"点击了%@",arr1[i]);
            return;//跳出这个函数
        }
    }
    for(int i=0;i<arr2.count;i++)
    {
        if(sender.tag==(200+1))//如果是这个的话
        {
            NSLog(@"点击了%@",arr2[i]);
            return;//跳出这个函数
        }
    }
}
-(void)hideview
{
    _cai.hidden=YES;
    _monney.hidden=YES;
    _paixu.hidden=YES;
    
}
-(void)credeview
{
    _cai=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64,pmwidth,pmheight-64)];
    _cai.userInteractionEnabled=YES;//可以点击
    _cai.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _monney=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64,pmwidth,pmheight-64)];
    _monney.userInteractionEnabled=YES;//可以点击
    _monney.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _paixu=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64,pmwidth,pmheight-64)];
    _paixu.userInteractionEnabled=YES;//可以点击
    _paixu.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}
-(void)LoadData
{
    NSLog(@"%@", _str);
    [_dataDic setValue:_str  forKey:@"categorycode"];//类型 可以修改660-673//每次下拉刷新数据
    [_dataDic setValue:@"100" forKey:@"apkversion"];//版本编号
    [_dataDic setValue:@"醉江月" forKey:@"appname"];//app名字
    [_dataDic setValue:@"v2.2.1.0703" forKey:@"apkversion"];//版本编号
    [_dataDic setValue:@"33285601411781238031" forKey:@"clientid"];//获取由 ASP.NET 生成的服务器控件标识符。
    //简单就是服务器控件在客户端的ID
    [_dataDic setValue:@"0" forKey:@"curpage"];//当前页面
    [_dataDic setValue:@"0" forKey:@"filtertype"];//过滤器类型
    [_dataDic setValue:@"0" forKey:@"filtervalue"];//Filter value配适值
    [_dataDic setValue:@"10986" forKey:@"groupid"];//是项目组织唯一的标识符
    [_dataDic setValue:@"864502023192438" forKey:@"imei"];//国际移动台设备识别码(IMEI)
    [_dataDic setValue:@"460001491957881" forKey:@"imsi"];//国际移动客户识别码(IMSI)
    [_dataDic setValue:@"com.dd.zjyue" forKey:@"packagename"];//应用包名
    [_dataDic setValue:@"15" forKey:@"pagesize"];//一页取多少个是15个
    [_dataDic setValue:@"720*1280" forKey:@"resolution"];//分辨率
    [_dataDic setValue:@"11814" forKey:@"shopid"];//卡号
    [_dataDic setValue:@"4f891256" forKey:@"signature"];//签名署名; 识别标志，鲜明特征; [医] 药的用法说明;
    [_dataDic setValue:@"0" forKey:@"unpackid"];//，打开
    [_dataDic setValue:@"a_4.4.2" forKey:@"versionrelease"];//版本好
    
}
-(void)urlAction:(NSInteger)num
{
    //头部刷新传过来的是1
    if(!_isfo)//判断是不是在刷新的时候可以刷新
    {
        _isfo=true;//表示现在在刷新了
        if(num==1)
        {
            [_dataSource removeAllObjects];//刷新的时候清空所有数据 2的直接往数组加元素
            _count=0;
        }else
        {
            _count++;//下拉_count++
        }
        [SVProgressHUD showInView:self.view status:@"正在加载数据...."];
        if(_dataDic==nil)
        {
            _dataDic=[NSMutableDictionary new];
        }
        [self LoadData];//字典有了数据
        
        [DataRequest postUrlstr:PATH parmeters:_dataDic finish:^(id dataString) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];//加载好数据后拿到数据
            [_dataSource addObjectsFromArray:[dic objectForKey:@"getDishList"]];//添加到加载数据中
            [tableview reloadData];
            _isfo=false;//表示刷新完成
            [SVProgressHUD dismissWithSuccess:@"加载完成"];
            [tableview.header endRefreshing];//关闭刷新
            [tableview.footer endRefreshing];//关闭加载
        } andError:^(NSError *error) {
        }];
    }else //如果刷新还没有完成在进入刷新那么
    {
        //判断是头部还是尾部
        if(num==1)
        {
            [tableview.header endRefreshing];//关闭刷新
        }else
        {
            [tableview.footer endRefreshing];//关闭加载
        }
    }
}
@end
