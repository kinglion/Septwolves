//
//  ActiveViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ActiveViewController.h"
#import "cView.h"
#import "detailViewController.h"
#import "JSONKit.h"
#define BIGLISTHEIGHT 160.0f
#define SMALLLISTHEIGHT 100.0f
#define SMALLLISTWIDTH 140.0f

@interface ActiveViewController ()

@end

@implementation ActiveViewController
@synthesize scrollView = _scrollView;
@synthesize array = _array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

//创建外围scrollView
-(UIScrollView*)creatTable
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setDelegate:self];
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}
//1、置顶列表
//需判断有无数据
-(void)creatBig:(UIView*)view
{
    cView *cview = [[cView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BIGLISTHEIGHT)];
    [cview setView:CGRectMake(0, 0, self.view.frame.size.width, BIGLISTHEIGHT) title:@"ssss" img:_array[0] cornerable:NO];
    cview.delegate = self;
    [view addSubview:cview];
    [cview release];
}
//2、小列表
//需判断有无数据
-(void)creatSmall:(UIView*)view
{
    int arrCount = [_array count] - 1;
    for (NSInteger i = 0; i<arrCount; i++) {
        cView *cview = [[cView alloc]initWithFrame:CGRectMake(10.0f+ (i % 2) * (SMALLLISTWIDTH + 10.0f), floor(i/2) * (SMALLLISTHEIGHT+10.0f) + BIGLISTHEIGHT + 10.0f, SMALLLISTWIDTH, SMALLLISTHEIGHT)];
        [cview setView:CGRectMake(10.0f+ (i % 2) * (SMALLLISTWIDTH + 10.0f), floor(i/2) * (SMALLLISTHEIGHT+10.0f) + BIGLISTHEIGHT + 10.0f, SMALLLISTWIDTH, SMALLLISTHEIGHT) title:@"ssss" img:_array[i] cornerable:YES];
        cview.delegate = self;
        [view addSubview:cview];
        [cview release];
    }
}

//更新scrollview的contentsize
-(void)updateScrollView:(UIScrollView*)scrollView
{
    int arrCount = [_array count] - 1;
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, BIGLISTHEIGHT + (floor(arrCount/2)-1) * (SMALLLISTHEIGHT+10.0f)+BIGLISTHEIGHT)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    str = @"{\"a\":123, \"imgArr\":[\"http://img.itc.cn/photo/jejJ6dJCVWW\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T963K.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95D6.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96048.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T921E.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T954410.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tca11.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132U012312.jpg\"]}";
    NSDictionary *data = [str objectFromJSONString];
    _array = [data objectForKey:@"imgArr"];
	// Do any additional setup after loading the view.
    if (_scrollView == nil) {
        _scrollView = [self creatTable];
        int arrCount = [_array count];
        NSLog(@"%d",arrCount);
        if (arrCount>0) {
            [self creatBig:_scrollView];
            [self creatSmall:_scrollView];
        }
        [self updateScrollView:_scrollView];
        NSLog(@"scrollView frameHeight:%f,contentHeight:%f",_scrollView.frame.size.height,_scrollView.contentSize.height);
        [self.view addSubview:_scrollView];
    }
    if (_refreshHeaderView == nil) {
		NSLog(@"scrollView.bounds.size.height:%f",self.scrollView.bounds.size.height);
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.scrollView.bounds.size.height, self.view.frame.size.width, self.scrollView.bounds.size.height)];
		view.delegate = self;
		[self.scrollView addSubview:view];
		_refreshHeaderView = view;
        [view release];
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)dealloc
{
    [super dealloc];
    _scrollView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现cViewController的触碰
- (void)touchEvent:(cView *)view
{
    detailViewController *viewController = [[detailViewController alloc]initWithNibName:@"detailViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
    NSLog(@"%@",@"sss");
}

@end
