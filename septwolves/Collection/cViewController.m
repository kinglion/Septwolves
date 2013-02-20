//
//  cViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "cViewController.h"
#import "cView.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#define CORNER 6
#define LABELHEIGHT 30

@interface cViewController ()

@end

@implementation cViewController
- (id)initWithFrame:(CGRect)frame title:(NSString*)text img:(NSString*)url cornerable:(BOOL)cable
{
    self = [super init];
    if(self){
        [self.view setFrame:frame];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //[imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pingBg.png"]];
        UIImage *image = [UIImage imageNamed:@"pingBg.png"];
        [imageView setImage:image];
        [self.view addSubview:imageView];
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
            self.view.layer.masksToBounds = YES;
            self.view.opaque = YES;
            self.view.layer.cornerRadius = CORNER;
            self.view.layer.borderWidth = 1.0;
            self.view.layer.borderColor = [[UIColor grayColor] CGColor];
        }
        [self.view addSubview:bottomlabel];
        [bottomlabel release];
        [imageView release];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch");
    if([self.delegate respondsToSelector:@selector(touchEvent:)])
    {
        [self.delegate touchEvent:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)viewDisTouch
{
    NSLog(@"touch");
}

@end
