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
@synthesize imageArr = _imageArr;
@synthesize imageViews = _imageViews;
@synthesize _id;
@synthesize bean;
@synthesize indicatorView;
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
    self.textView.backgroundColor = [UIColor blackColor];
    LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    [self.view addSubview:tempIndicatorView];
    self.indicatorView = tempIndicatorView;
    self.bean = [LNconst httpRequestNewInfo:self.indicatorView id:self._id];
    [self.textLabel setText:bean.time];
    NSString *postHTML = bean.content;
    
    NSString *structure =[NSString stringWithFormat:@"<html><head><style type='text/css'>iframe {width:290px; height:auto; background-color:#000; color:#ffffff;} object {width:290px; height:auto; color:#ffffff;} blockquote {font-family:Arial; color:#ffffff;}img{width:290px; height:auto; display: block; margin-left: 0px; margin-right: auto} p {text-indent:2em; font-family:Arial; color:#ffffff;}   body {color:#ffffff;background-color:#000000; text-indent:2em;} h1 {font-family:Arial; color:#ffffff;} h2 {font-family:Arial; color:#ffffff;} h3 {font-family:Arial; color:#ffffff;} h4 {font-family:Arial; color:#ffffff;} h5 {font-family:Arial; color:#ffffff;} h6 {font-family:Arial; color:#ffffff;} li {font-family:Arial; color:#ffffff;} b {font-family:Arial; color:#ffffff;}</style></head><body>"];
    NSString *close =[NSString stringWithFormat:@"</body></html>"];
    
    NSString *HTMLString = [NSString stringWithFormat:@"%@%@%@", structure, postHTML, close];
    [self.textView loadHTMLString:HTMLString baseURL:nil];
    if ([bean.type isEqual:@"image"]) {
        imageArr = [[NSMutableArray alloc]init];
        for (NewBean *img in self.bean.imgList) {
            [imageArr addObject:img.url];
        }
        SliderView *view = [[SliderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _topView.frame.size.width, _topView.frame.size.height)];
        view.delegate = self;
        [view setFrame:CGRectMake(0.0f, 0.0f, _topView.frame.size.width, _topView.frame.size.height) ImageArr:imageArr];
        [_topView addSubview:view];
        [view release];
    }else{
        VideoView *view = [[VideoView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _topView.frame.size.width, _topView.frame.size.height)];
        view.delegate = self;
        [self.topView addSubview:view];
        [view release];
    }
    [tempIndicatorView release];
    // Do any additional setup after loadßing the view from its nib.
}

- (void)updateId:(NSInteger)newID
{
    self._id = newID;
}

- (void)touchEvent:(VideoView *)view
{
    MPMoviePlayerViewController *viewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.bean.vedioUrl]];
    [self presentMoviePlayerViewControllerAnimated:viewController];
    [view setAlpha:1.0f];
}

#pragma mark - ASMediaFocusDelegate
- (UIImage *)mediaFocusManager:(ASMediaFocusManager *)mediaFocusManager imageForView:(UIView *)view
{
    return ((UIImageView *)view).image;
}

- (CGRect)mediaFocusManager:(ASMediaFocusManager *)mediaFocusManager finalFrameforView:(UIView *)view
{
    return self.parentViewController.view.bounds;
}

- (UIViewController *)parentViewControllerForMediaFocusManager:(ASMediaFocusManager *)mediaFocusManager
{
    return self.parentViewController;
}

- (NSString *)mediaFocusManager:(ASMediaFocusManager *)mediaFocusManager mediaUrlForView:(UIView *)view
{
    NSString *url;
    // Here, images are accessed through their name "1f.jpg", "2f.jpg",
    NSLog(@"======");
    url = [self.imageArr objectAtIndex:[self.imageViews indexOfObject:view]];
    return url;
}

- (void)touchView:(SliderView *)view ASMediaFocusManager:(ASMediaFocusManager *)mediaFocusManager images:(NSMutableArray *)images
{
    NSLog(@"==========");
    mediaFocusManager.delegate = self;
    self.imageViews = images;
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
