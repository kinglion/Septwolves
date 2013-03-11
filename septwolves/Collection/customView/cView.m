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
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void)setView:(CGRect)frame title:(NSString*)text img:(NSString*)url cornerable:(BOOL)cable
{
    // Initialization code
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pingeBg.png"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    //UIImage *image = [UIImage imageNamed:@"pingBg.png"];
    //[imageView setImage:image];
    [self addSubview:imageView];
    //CALayer *layer = [CALayer layer];
    //layer.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
    //layer.contentsGravity = kCAGravityResizeAspect;
    //layer.contents = (id)[UIImage imageNamed:@"pingeBg.png"].CGImage;
    //[[self layer] addSublayer:layer];
    UILabel *bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - LABELHEIGHT, frame.size.width,LABELHEIGHT)];
    self.title = text;
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
    [self addSubview:bottomlabel];
    [bottomlabel release];
    [imageView release];
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

- (NSString *)getTitle
{
    NSString* str = self.title;
    return str;
}

@end
