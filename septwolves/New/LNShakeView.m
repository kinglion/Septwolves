//
//  LNShakeView.m
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNShakeView.h"
#import <QuartzCore/QuartzCore.h>
#define IMAGE_WIDTH 140.0f
#define IMAGE_HEIGHT 175.0f

@implementation LNShakeView
@synthesize lists;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setImageDate:(NSArray *)imageList
{
    self.lists = imageList;
    [self reSetView];
}

- (void)reSetView
{
    int length = [[self subviews]count];
    if (length != 0) {
        for (UIView *view in [self subviews]) {
            [view removeFromSuperview];
            view = nil;
        }
    }
    for (int i = 0; i < [lists count]; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"man1.png"]];
        float x = (self.frame.size.width - (2*IMAGE_WIDTH + 10))/2+(IMAGE_WIDTH+10)*(i%2);
        float y = (self.frame.size.height - (2*IMAGE_HEIGHT + 10))/2+(IMAGE_HEIGHT+10)*(i/2);
        NSLog(@"%f",self.frame.size.height);
        [iv setFrame:CGRectMake(x, y, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [iv.layer setBorderWidth:5.0f];
        [iv.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [iv.layer setShadowColor:[[UIColor grayColor] CGColor]];
        [iv.layer setShadowOffset:CGSizeMake(0.5f, 0.5f)];
        [self addSubview:iv];
        [iv release];
    }
}

- (void)shake
{
    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 40, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -40, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    
    [UIView animateWithDuration:0.1 animations:^{
        // Translate left
        self.transform = moveLeft;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            // Translate right
            self.transform = moveRight;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                // Translate left
                self.transform = moveLeft;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.1 animations:^{
                    
                    // Translate to origin
                    self.transform = resetTransform;
                }];
            }];
            
        }];
    }];
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
