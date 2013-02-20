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

@implementation cView{
    BOOL testHits; 
}
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
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    // Drawing code
    
}
/*
-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if(testHits){
        return nil;
    }
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        testHits = YES;
        CGPoint superPoint = [self.superview convertPoint:point fromView:self];
        
        if(self.superview != nil){
            UIView *superHitView = [self.superview hitTest:superPoint withEvent:event];
            testHits = NO;
            hitView = superHitView;
        }
        
    }
    return hitView;
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:0.6f];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder]touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setAlpha:1];
    [[self nextResponder]touchesEnded:touches withEvent:event];
}


@end
