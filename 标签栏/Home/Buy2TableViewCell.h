//
//  Buy2TableViewCell.h
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Buy1ViewController.h"

@interface Buy2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UILabel *caiName;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIImageView *startImage;
@property (weak, nonatomic) IBOutlet UILabel *smalltext;
@property (nonatomic,retain)Buy1ViewController* home;
@end
