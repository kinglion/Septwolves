//
//  CustomCell.h
//  septwolves
//
//  Created by 小才 on 13-3-20.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WIDTH_TIME 70.0f
@interface CustomCell : UITableViewCell
{
    UILabel *timeLabel;
    UILabel *mainLabel;
}
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *mainLabel;
@end
