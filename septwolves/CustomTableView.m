//
//  CustomTableView.m
//  septwolves
//
//  Created by 小才 on 13-3-20.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_TIME, self.frame.size.height)];
        UIGraphicsBeginImageContext(tempImageView.frame.size);
        [tempImageView.image drawInRect:CGRectMake(0, 0, tempImageView.frame.size.width, tempImageView.frame.size.height)];
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.5, 0.5, 0.5, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), tempImageView.frame.size.width - 1, 0);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), tempImageView.frame.size.width - 1, tempImageView.frame.size.height - 4);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        tempImageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self addSubview:tempImageView];
        [tempImageView release];
    }
    return self;
    
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
