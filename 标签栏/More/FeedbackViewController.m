//
//  FeedbackViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "FeedbackViewController.h"
#import "RootViewController.h"
#import "AppDelegate.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@end

@implementation FeedbackViewController

-(void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];//即将出现的时候出现这个
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settt:@"用户反馈"];
    [self setleftbutton:nil andBackImageName:@"NO.png"];
    [self framed];
    _bigtext.layer.masksToBounds=YES;
    _bigtext.layer.cornerRadius=5;
    _smalltext.layer.masksToBounds=YES;
    
    _smalltext.layer.cornerRadius=5;
    _btn.layer.masksToBounds=YES;
    _btn.layer.cornerRadius=5;
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)tapAction:(UITapGestureRecognizer*)tap
{
    [_smalltext resignFirstResponder];
    [_bigtext resignFirstResponder];
}
-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sender:(UIButton *)sender
{
    [_bigtext resignFirstResponder];
    [_smalltext resignFirstResponder];
    if(sender.tag==1)//点击了以
    {
        
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault  handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    _bigtext.text=@"请输入您反馈意见!(字数:300字以内)";
    _smalltext.text=@"你的联系方式(选填,字数:50字以内)";
    
}
-(void)framed
{
    //    @property (weak, nonatomic) IBOutlet UITextView *bigtext;
    //    @property (weak, nonatomic) IBOutlet UITextView *smalltext;
    //    @property (weak, nonatomic) IBOutlet UIButton *btn;
    //    @property (weak, nonatomic) IBOutlet UILabel *text;
    //    @property (weak, nonatomic) IBOutlet UIButton *btn2;
    _text.frame=CGRectMake(10, pmwidth/3-64,pmwidth-20, 60);
    _bigtext.frame=CGRectMake(20,_text.frame.origin.y+_text.frame.size.height,pmwidth-40,180);
    _smalltext.frame=CGRectMake(20,_bigtext.frame.origin.y+_bigtext.frame.size.height+20, pmwidth-40,120);
    _btn.frame=CGRectMake(40,_smalltext.frame.origin.y+_smalltext.frame.size.height+20, 60,40);
    _btn2.frame=CGRectMake(pmwidth-100,_smalltext.frame.origin.y+_smalltext.frame.size.height+20, 60,40);
    _bigtext.delegate=self;
    _smalltext.delegate=self;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"开始编辑");
    if([textView isEqual:_bigtext])
    {
        if([_bigtext.text rangeOfString:@"请输入您反馈意见!(字数:300字以内)"].location!=NSNotFound)
        {
            _bigtext.text=@"";
        }
    }else
    {
        if([_smalltext.text rangeOfString:@"你的联系方式(选填,字数:50字以内)"].location!=NSNotFound)
        {
            _smalltext.text=@"";
        }
    }
    
    
}
//编辑后
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(_bigtext.text.length==0)
    {
        _bigtext.text=@"请输入您反馈意见!(字数:300字以内)";
    }
    if(_smalltext.text.length==0)
    {
        _smalltext.text=@"你的联系方式(选填,字数:50字以内)";
    }
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
