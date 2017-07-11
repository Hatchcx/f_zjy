//
//  Buy3ViewController.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/4.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "Buy3ViewController.h"

@interface Buy3ViewController ()<UITextFieldDelegate>
@property(assign)int count;//购买的数量
@end

@implementation Buy3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 1;
    [self bulieNav:@"我的点餐" andleftimagename:@"NO.png" andrightmagename:@"YES.png"];
    _name.text=_cainame;
    _qian.text=_mone;
    _xiaoqian.text=_smallmone;
    _bigImage.image=_image;
    _bigImage.layer.masksToBounds=YES;
    _bigImage.layer.cornerRadius=5;
    _vieww.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _texfile.delegate=self;
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}
-(void)tapAction:(UITapGestureRecognizer*)tap
{
    [_texfile resignFirstResponder];
}
-(void)leftAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction:(UIButton*)sender
{
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"购买成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault  handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)addAction:(id)sender {
    if(_count>1)
    {
        _count--;//减
        //
        _num.text=[NSString stringWithFormat:@"%d",_count];
        _texfile.text=[NSString stringWithFormat:@"%d",_count];
    }
}
- (IBAction)jianAction:(id)sender {
    _count++;
    _num.text=[NSString stringWithFormat:@"%d",_count];
    _texfile.text=[NSString stringWithFormat:@"%d",_count];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _count=[_texfile.text intValue];
    NSLog(@"%@",_texfile.text);
    _num.text=[NSString stringWithFormat:@"%d",_count];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
