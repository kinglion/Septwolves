//
//  CustomCell.m
//  septwolves
//
//  Created by 小才 on 13-3-20.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomCell
@synthesize timeLabel,mainLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH_TIME, self.frame.size.height)];
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
        [tempLabel setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0]];
        [tempLabel setTextAlignment:NSTextAlignmentCenter];
        [tempLabel setTextColor:[UIColor blackColor]];
        [self addSubview:tempLabel];
        [tempLabel addSubview:tempImageView];
        self.timeLabel = tempLabel;
        [tempLabel release];
        UILabel *stempLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_TIME + 20, 0, self.frame.size.width - WIDTH_TIME - 20, self.frame.size.height)];
        [stempLabel setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0]];
        [stempLabel setTextColor:[UIColor blackColor]];
        [self addSubview:stempLabel];
        self.mainLabel = stempLabel;
        [stempLabel release];
        //[self setNeedsDisplay];
    }
    return self;
}

/*- (void)drawRect:(CGRect)rect
{
    //CGContextBeginPath(UIGraphicsGetCurrentContext());
    //CGContextMoveToPoint(UIGraphicsGetCurrentContext(), WIDTH_TIME, 0);
    //CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), WIDTH_TIME, self.frame.size.height);
    //CGFloat grelColor[4]={0.5,0.5,0.5,0.0};
    //CGContextSetStrokeColor(UIGraphicsGetCurrentContext(), grelColor);
    //CGContextSetFillColor(UIGraphicsGetCurrentContext(), grelColor);
    //CGContextStrokePath(UIGraphicsGetCurrentContext());
    //CGContextFillPath(UIGraphicsGetCurrentContext());
}*/

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
