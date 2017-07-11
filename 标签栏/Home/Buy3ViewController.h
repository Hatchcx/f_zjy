//
//  Buy3ViewController.h
//  醉江月
//
//  Created by 黄启明 on 2017/1/4.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "NavigationViewController.h"

@interface Buy3ViewController : NavigationViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *vieww;
@property (weak, nonatomic) IBOutlet UITextField *texfile;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *jian;
@property (weak, nonatomic) IBOutlet UIButton *xin;
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UILabel *xiaoqian;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *qian;
@property (weak, nonatomic) IBOutlet UIButton *dele;
@property(nonatomic,retain)NSString* mone;//钱
@property(nonatomic,retain)NSString* smallmone;//小钱
@property(nonatomic,retain)NSString* cainame;//菜名字
@property(nonatomic,retain)UIImage* image;//image
@end
