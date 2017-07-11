//
//  MenuViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "MenuViewController.h"
#import "DataRequest.h"
#import "UIImageView+WebCache.h"
#define kMenuUrlString @"http://api.cy.daoyoudao.com/app/showmenu.do?groupid=10986&shopid=0&industry=re&clientid=&systype=ios"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self bulieNav:self.title andleftimagename:nil andrightmagename:@"cainav..png"];
    [self downLoadData];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    float with=(pmwidth-40)/7;//x
    float height=with;
    pmwidth;//屏幕宽
    pmheight;//屏幕高
    float khx=(pmwidth-40)/7;//空白位置的x   每个x轴的是
    float khy=(pmheight-height*6)/2;//y轴的空格
    int a=0;
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<4;j++,a++)
        {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(20+j*(khx+with),khy+i*height*2,with, height);
            UIImageView* im=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, with, height)];
            im.image=[UIImage imageNamed:@"star_gray.png"];
            [btn addSubview:im];
            UILabel* laber=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x,btn.frame.origin.y+height+10,btn.frame.size.width,10)];
            laber.textAlignment=1;
            if(pmwidth<414)
            {
                laber.font=[UIFont systemFontOfSize:9];
            }else
            {
                laber.font=[UIFont systemFontOfSize:13];
            }
            btn.tag=(100+a);
            im.tag=10;
            laber.tag=40+a;
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:laber];
            [self.view addSubview:btn];
        }
    }
}
-(void)btnAction:(UIButton*)sender
{
    NSLog(@"点击了tag为:%ld的按钮",sender.tag);
    
}
-(void)downLoadData//加载数据
{
    
    [DataRequest getUrlStr:kMenuUrlString finish:^(id dataString) {//成功加载到数据
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
        NSArray* arr=[dic objectForKey:@"infomemo"];
        for(int i=0;i<arr.count;i++)
        {
            UIButton* btn=[self.view viewWithTag:(100+i)];//从一开始
            UIImageView* im=[btn viewWithTag:10];//找到im
            //设置im的图片
            [im setImageWithURL:[NSURL URLWithString:[arr[i] objectForKey:@"showpic"]] placeholderImage:[UIImage imageNamed:@"star_gray.png"]];
            UILabel* laber=[self.view viewWithTag:40+i];
            laber.text=[arr[i] objectForKey:@"title"];
        }
        
    } andError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
