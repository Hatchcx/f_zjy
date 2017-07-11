//
//  IntroductionViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "IntroductionViewController.h"
#import "UIImageView+WebCache.h"

@interface IntroductionViewController ()
@property(nonatomic,retain)UIImageView* imageview;//图片
@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settt:@"企业简介"];
    [self setleftbutton:nil andBackImageName:@"NO.png"];
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, pmwidth, pmheight/3)];
    [_imageview setImageWithURL:@"http://m.cy.daoyoudao.com/upload/10986/corp/2013071/1372668418-b.jpg"  placeholderImage:[UIImage imageNamed:@"icon@2x.png"]];
    [self.view addSubview:_imageview];
    UILabel* laber=[[UILabel alloc]initWithFrame:CGRectMake(40, 84+pmheight/3,80, 20)];
    laber.font=[UIFont systemFontOfSize:12];
    laber.text=@"企业官网:";
    //网址按钮
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0,84+pmheight/3,pmwidth,20);
    [btn setTitle:@"www.zuijiangyue.com" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-60,104+pmheight/3 ,120,1)];
    view.backgroundColor=[UIColor blueColor];
    
    //企业微博
    UILabel* laber1=[[UILabel alloc]initWithFrame:CGRectMake(20,120+pmheight/3,pmwidth-40,80)];
    laber1.text=@"企业微博 : @武汉醉江月饮食服务有限公司";
    laber1.numberOfLines=0;
    
    //
    UIScrollView* scorll=[[UIScrollView alloc]initWithFrame:CGRectMake(20,200+pmheight/3,pmwidth-40,pmheight)];
    UILabel* laber2=[[UILabel alloc]initWithFrame:CGRectMake(0,0,pmwidth-40 ,pmheight)];
    laber2.numberOfLines=0;
    laber2.text=@" 武汉市醉江月饮食服务有限公司创立于1997年，是武汉餐饮酒店中的知名品牌，现拥有紫阳店、度假村、欢乐谷店以及 “盈喜客”中式快餐连锁店。2012年青山店全线升级迁址欢乐谷店，是为顾客提供集餐饮、客房、会务、旅游、中式快餐等多元化服务于一体的企业。公司始终坚持“真真正正、百姓美食”的经营理念，以建百年老店为目标。以环境留人、菜肴留客、价格留心、服务留情为经营方针。挖掘荆楚饮食文化的精深内涵，开拓创新，借鉴引进粤、川、扬菜之精华，与传统鄂菜进行有机结合，开发出众多颇具醉江月特色的“新武汉菜”。在全国第十三届、十五届厨师节上“楚才宴” “开元生肖宴”先后被评为“中国名宴”、宴席创新金奖、“中华金厨奖”人才培育贡献奖；“2012年世界厨王争霸赛”武汉醉江月代表队勇夺季军；2012年公司董事长苏忠高先生在中国烹饪协会成立25周年庆典上荣获“中国烹饪大师金爵奖”。多年来公司先后被评为“中华餐饮名店”、“鄂菜特色餐饮名店”、“鄂菜发展十大名店”、“湖北省消费者满意单位”、“武汉人最喜爱的餐饮名店”、“守合同重信用企业”、武汉市信用企业、武汉市优秀企业等，并荣获湖北省著名商标。公司始终坚持“员工满意、顾客满意、社会满意”的核心价值观，有健全的党总支、工会、团总支部。先后被评为“武昌区最佳文明单位”、武汉市“双比双争”先进基层党组织、武汉市“和谐企业”、武昌区“十佳吴天祥小组”、“湖北省爱心单位”，湖北省“双爱双评”先进单位、省级模范职工小家，团总支被授予了武汉市五四红旗团支部（总支）标兵、武汉市三星级民主管理单位、武汉市区优秀和谐企业。";
    scorll.contentSize=CGSizeMake(0,pmheight+pmheight/2);
    scorll.showsVerticalScrollIndicator=NO ;
    [scorll addSubview:laber2];
    [self.view addSubview:scorll];
    [self.view addSubview:btn];
    [self.view addSubview:view];
    [self.view addSubview:laber1];
    [self.view addSubview:laber];
    
    
    
    
    // [imageview setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>];
    // Do any additional setup after loading the view from its nib.
}
-(void)btnAction
{
    NSLog(@"点击了网址");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
