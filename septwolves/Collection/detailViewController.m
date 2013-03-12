//
//  detailViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "detailViewController.h"
#import "SliderView.h"
#import "VideoView.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface detailViewController ()

@end

@implementation detailViewController
@synthesize topView = _topView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage* backImage = [UIImage imageNamed:@"backButton.png"];
        CGRect backframe = CGRectMake(0,0,30,19);
        UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        [leftBarButtonItem release];
        [backButton release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"indexBG.png",@"mannoone.png", nil];
    //SliderView *view = [[SliderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _topView.frame.size.width, _topView.frame.size.height) ImageArr:array];
    VideoView *view = [[VideoView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _topView.frame.size.width, _topView.frame.size.height)];
    view.delegate = self;
    [self.topView addSubview:view];
    [array release];
    [view release];
    // Do any additional setup after loadßing the view from its nib.
}

- (void)touchEvent:(VideoView *)view
{
    MPMoviePlayerViewController *viewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://movies.apple.com/media/us/iphone/2010/tours/apple-iphone4-design_video-us-20100607_848x480.mov"]];
    [self presentMoviePlayerViewControllerAnimated:viewController];
    [view setAlpha:1.0f];
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [_topView release];
    _topView = nil;
}

@end
