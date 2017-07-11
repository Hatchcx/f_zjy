//
//  FeedbackViewController.h
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "NavigationViewController.h"

@interface FeedbackViewController : NavigationViewController
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UITextView *bigtext;
@property (weak, nonatomic) IBOutlet UITextView *smalltext;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
