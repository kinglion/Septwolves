//
//  cView.m
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "cView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#define CORNER 6
#define LABELHEIGHT 30

@implementation cView
@synthesize imageView,label,title,img,cornerable;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)text img:(NSString*)url cornerable:(BOOL)cable
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)]autorelease];
        //[imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pingBg.png"]];
        [imageView setImage:[UIImage imageNamed:@"pingBg.png"]];
        UILabel *bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - LABELHEIGHT, frame.size.width,LABELHEIGHT)];
        [bottomlabel setText:text];
        [bottomlabel setTextAlignment:NSTextAlignmentCenter];
        [bottomlabel setTextColor:[UIColor whiteColor]];
        [bottomlabel setBackgroundColor:[UIColor blackColor]];
        bottomlabel.opaque = YES;
        [bottomlabel setAlpha:0.6f];
        if (cable)
        {
            // 圆角
            self.layer.masksToBounds = YES;
            self.opaque = YES;
            self.layer.cornerRadius = CORNER;
            self.layer.borderWidth = 1.0;
            self.layer.borderColor = [[UIColor grayColor] CGColor];
        }
        [self addSubview:imageView];
        [self addSubview:bottomlabel];
        [bottomlabel release];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    // Drawing code
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:0.6f];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:1];
}

@end
