//
//  ChrConsuView.m
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ChrConsuView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define LABELHEIGHT 30.0f
@implementation ChrConsuView
@synthesize imageCount = _imageCount;
@synthesize label = _label;
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl title:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
        UIImageView *imageView;
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.frame.size.height - LABELHEIGHT, self.frame.size.width, LABELHEIGHT)];
        _label.text = text;
        UIColor *color = [[UIColor alloc] initWithRed:0.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:0.5];
        [_label setBackgroundColor:color];
        [_label setTextColor:[UIColor whiteColor]];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
        //NSLog(@"%d",arc4random() % 0xffffffffu);
        [self addSubview:imageView];
        [imageView release];
        [self addSubview:_label];
        [_label release];
        [color release];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    _label = nil;
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
