//
//  LNView.h
//  septwolves
//
//  Created by 小才 on 13-3-13.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BREAK_LINE_HEIGHT 2.0f
#define BREAK_LINE_CONTENT_BACKGROUND_COLOR [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1]
#define BREAK_LINE_BACKGROUND_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]

@interface LNView : UIView

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor cornerable:(BOOL)cornerable floors:(NSMutableArray *)floors;
//绘制分割线
- (UIView *)drawLine:(CGRect)frame;
@end
