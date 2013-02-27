//
//  ChrConsuView.h
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChrConsuView;
@protocol ChrConsuViewDelegate

@optional
- (void)touchEvent:(ChrConsuView *)view;
@end

@interface ChrConsuView : UIView

@property(nonatomic,assign) id <ChrConsuViewDelegate> delegate;
@property (nonatomic,assign)NSInteger imageCount;
@property (nonatomic,retain)UILabel *label;
- (id)initWithFrame:(CGRect)frame imageArr:(NSMutableArray *)array title:(NSString*)text;
@end
