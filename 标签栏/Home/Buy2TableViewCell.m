//
//  Buy2TableViewCell.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "Buy2TableViewCell.h"
#import "Buy3ViewController.h"

@implementation Buy2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (IBAction)btnAction:(id)sender {
    Buy3ViewController* buy=[[Buy3ViewController alloc]init];//进入
    //把本身的图片穿下去
    [_home.navigationController pushViewController:buy animated:YES];//过去
    buy.image=_bigImage.image;
    buy.mone=_money.text;
    buy.smallmone=_smalltext.text;
    buy.cainame=_caiName.text;
}

@end
