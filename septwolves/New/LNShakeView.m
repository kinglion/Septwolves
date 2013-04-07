//
//  LNShakeView.m
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNShakeView.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
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
        UIImageView *iv = [[UIImageView alloc]init];
        [iv setImageWithURL:[NSURL URLWithString:[lists objectAtIndex:i]]];
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
                    [self.delegate shakeAnimateFinished:self];
                }];
            }];
            
        }];
    }];
}

- (void)pull
{
    int length = [[self subviews]count];
    NSArray *arr = [self subviews];
    [UIView animateWithDuration:1.0 animations:^{
        for (int i = 0; i < length; i++) {
            UIImageView *iv = [arr objectAtIndex:i];
            float x,y;
            if (i < length / 2) {
                x = (self.frame.size.width - (2*IMAGE_WIDTH + 10))/2+(IMAGE_WIDTH+10)*(i%2);
                y = -(IMAGE_HEIGHT+10)*(i/2);
            }else{
                x = (self.frame.size.width - (2*IMAGE_WIDTH + 10))/2+(IMAGE_WIDTH+10)*(i%2);
                y = (self.frame.size.height + (2*IMAGE_HEIGHT + 10))/2+(IMAGE_HEIGHT+10)*(i/2);
            }
            NSLog(@"%f",self.frame.size.height);
            [iv setFrame:CGRectMake(x, y, IMAGE_WIDTH, IMAGE_HEIGHT)];
        }
    } completion:^(BOOL finished) {
        for (UIView *item in [self subviews]) {
            [item removeFromSuperview];
        }
        [self.delegate pullAnimateFinished:self];
    }];
}

- (void)push
{
    int length = [[self subviews]count];
    if (length != 0) {
        for (UIView *view in [self subviews]) {
            [view removeFromSuperview];
            view = nil;
        }
    }
    for (int i = 0; i < [lists count]; i++) {
        UIImageView *iv = [[UIImageView alloc]init];
        [iv setImageWithURL:[NSURL URLWithString:[lists objectAtIndex:i]]];
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
    [self.delegate pushAnimateFinished:self];
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
