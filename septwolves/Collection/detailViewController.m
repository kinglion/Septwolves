//
//  detailViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "detailViewController.h"
#import "SliderView.h"

@interface detailViewController ()

@end

@implementation detailViewController
@synthesize topView = _topView;

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
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"indexBG.png",@"mannoone.png", nil];
    SliderView *view = [[SliderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _topView.frame.size.width, _topView.frame.size.height) ImageArr:array];
    [self.topView addSubview:view];
    [array release];
    [view release];
    // Do any additional setup after loading the view from its nib.
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
