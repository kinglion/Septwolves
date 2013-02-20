//
//  ActiveViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ActiveViewController.h"
#import "cViewController.h"
#define BIGLISTHEIGHT 160
#define SMALLLISTHEIGHT 100
#define SMALLLISTWIDTH 140  

@interface ActiveViewController ()

@end

@implementation ActiveViewController
@synthesize scrollView = _scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scrollView = [self creatTable];
        [self creatBig:_scrollView];
        [self creatSmall:_scrollView];
        [self updateScrollView:_scrollView];
        NSLog(@"scrollView frameHeight:%f,contentHeight:%f",_scrollView.frame.size.height,_scrollView.contentSize.height);
        [self.view addSubview:_scrollView];
    }
    return self;
}

//创建外围scrollView
-(UIScrollView*)creatTable
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setDelegate:self];
    scrollView.pagingEnabled = YES;
    return scrollView;
}
//1、置顶列表
//需判断有无数据
-(void)creatBig:(UIView*)view
{
    cViewController *cview = [[cViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BIGLISTHEIGHT) title:@"ssss" img:@"http://t3.baidu.com/it/u=3644186789,3529490292&fm=24&gp=0.jpg" cornerable:NO];
    cview.delegate = self;
    [view addSubview:cview.view];
    [cview release];
}
//2、小列表
//需判断有无数据
-(void)creatSmall:(UIView*)view
{
    for (NSInteger i = 0; i<10; i++) {
        cViewController *cview = [[cViewController alloc]initWithFrame:CGRectMake(10+ (i % 2) * (SMALLLISTWIDTH + 10), floor(i/2) * (SMALLLISTHEIGHT+10) + BIGLISTHEIGHT + 10, SMALLLISTWIDTH, SMALLLISTHEIGHT) title:@"ssss" img:@"http://t3.baidu.com/it/u=3644186789,3529490292&fm=24&gp=0.jpg" cornerable:YES];
        cview.delegate = self;
        [view addSubview:cview.view];
        [cview release];
    }
}

//更新scrollview的contentsize
-(void)updateScrollView:(UIScrollView*)scrollView
{
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, BIGLISTHEIGHT + floor(9/2) * (SMALLLISTHEIGHT+10) + BIGLISTHEIGHT + 10)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)dealloc
{
    [super dealloc];
    [_scrollView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现cViewController的触碰
- (void)touchEvent:(cViewController *)viewController
{
    NSLog(@"%@",@"sss");
}

@end
