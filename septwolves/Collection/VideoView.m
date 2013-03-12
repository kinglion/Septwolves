//
//  VideoView.m
//  septwolves
//
//  Created by 小才 on 13-2-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "VideoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation VideoView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
        [imageView setImageWithURL:[NSURL URLWithString:@"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg"]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:imageView];
        UIView *view = [[UIView alloc]initWithFrame:self.frame];
        [view setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5]];
        [self addSubview:view];
        [imageView release];
        [view release];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:0.6f];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:1];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [_delegate touchEvent:self];
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
