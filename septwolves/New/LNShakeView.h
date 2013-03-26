//
//  LNShakeView.h
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNShakeView : UIView
{
    NSArray *lists;
}
@property (nonatomic,retain) NSArray *lists;
- (void)shake;
- (void)setImageDate:(NSArray *)imageList;
@end
