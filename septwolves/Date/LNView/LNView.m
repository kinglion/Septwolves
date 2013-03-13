//
//  LNView.m
//  septwolves
//
//  Created by 小才 on 13-3-13.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LNView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor cornerable:(BOOL)cornerable floors:(NSMutableArray *)floors
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:backgroundColor];
        if (cornerable)[[self layer] setCornerRadius:5.0f];
        float sumHeight = 0.0f;
        int floorsCount = [floors count];
        if (floorsCount > 1) {
            for (int i = 0; i < floorsCount; i++) {
                UIView *view = floors[i];
                [view setCenter:CGPointMake(self.center.x, view.center.y + sumHeight)];
                [self addSubview:view];
                sumHeight += view.frame.size.width;
                UIView *line = [self drawLine:CGRectMake(0, sumHeight, self.frame.size.width, BREAK_LINE_HEIGHT)];
                [self addSubview:line];
                sumHeight += BREAK_LINE_HEIGHT;
            }
        }else{
            UIView *view = floors[0];
            [view setCenter:CGPointMake(self.center.x, view.center.y + sumHeight)];
            [self addSubview:view];
        }
    }
    return self;
}

- (UIView *)drawLine:(CGRect)frame
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIView *viewContent = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1.0f)];
    [viewContent setBackgroundColor:BREAK_LINE_CONTENT_BACKGROUND_COLOR];
    [view addSubview:viewContent];
    [view setBackgroundColor:BREAK_LINE_BACKGROUND_COLOR];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
