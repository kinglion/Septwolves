//
//  LNActivityInditorView.m
//  septwolves
//
//  Created by 小才 on 13-3-15.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNActivityIndicatorView.h"
#define INDICATOR_WIDTH 20.0f
#define INDICATOR_HEIGHT 20.0f
@implementation LNActivityIndicatorView
@synthesize indicatorView;
@synthesize coverView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:NO];
        if (self.coverView == nil) {
            UIView *tempCoverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [tempCoverView setBackgroundColor:[UIColor blackColor]];
            [tempCoverView setAlpha:0.5];
            [tempCoverView setHidden:YES];
            [self addSubview:tempCoverView];
            self.coverView = tempCoverView;
            [tempCoverView release];
        }
        if (self.indicatorView == nil) {
            UIActivityIndicatorView *tempActivityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, INDICATOR_WIDTH, INDICATOR_HEIGHT)];
            [tempActivityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [tempActivityIndicatorView setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
            [self addSubview:tempActivityIndicatorView];
            self.indicatorView = tempActivityIndicatorView;
            [tempActivityIndicatorView release];
        }
    }
    return self;
}

- (void)startAnimating
{
    [self.indicatorView startAnimating];
    [self.coverView setHidden:NO];
    [self setUserInteractionEnabled:YES];
}

- (void)stopAnimating
{
    [self.indicatorView stopAnimating];
    [self.coverView setHidden:YES];
    [self setUserInteractionEnabled:NO];
}

- (void)dealloc
{
    [indicatorView release];
    [coverView release];
    [super dealloc];
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
