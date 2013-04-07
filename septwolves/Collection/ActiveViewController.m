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
#define BIGLISTHEIGHT 188.0f
#define SMALLLISTHEIGHT 100.0f
#define SMALLLISTWIDTH 150.0f
#define NAVIGATIONHEIGHT 44.0f

@interface ActiveViewController (Private) <UIScrollViewDelegate>

@end

@implementation ActiveViewController
@synthesize scrollView = _scrollView;
@synthesize indicatorView;
@synthesize _refreshHeaderView;
@synthesize _refreshFooterView;
@synthesize bean;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blackColor]];
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

//创建外围scrollView
-(UIScrollView*)creatTable
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - NAVIGATIONHEIGHT)];
    NSLog(@"navigationController.height:%f",self.navigationController.view.frame.size.height);
    [scrollView setDelegate:self];
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}
//1、置顶列表
//需判断有无数据
-(void)creatBig:(UIView*)view
{
    cView *cview = [[cView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BIGLISTHEIGHT)];
    [cview setView:CGRectMake(0, 0, self.view.frame.size.width, BIGLISTHEIGHT) title:[[self.bean.list objectAtIndex:0] title] img:[[self.bean.list objectAtIndex:0] imgUrl] cornerable:NO];
    [cview set_id:[[self.bean.list objectAtIndex:0] _id]];
    cview.delegate = self;
    [view addSubview:cview];
    [cview release];
}
//2、小列表
//需判断有无数据
-(void)creatSmall:(UIView*)view
{
    int arrCount = [self.bean.list count] - 1;
    if(arrCount < 2)return;
    for (NSInteger i = 1; i<arrCount; i++) {
        NSInteger copyI = i - 1;
        cView *cview = [[cView alloc]initWithFrame:CGRectMake(10.0f+ (copyI % 2) * (SMALLLISTWIDTH + 10.0f), floor(copyI/2) * (SMALLLISTHEIGHT+10.0f) + BIGLISTHEIGHT + 10.0f, SMALLLISTWIDTH, SMALLLISTHEIGHT)];
        [cview setView:CGRectMake(10.0f+ (copyI % 2) * (SMALLLISTWIDTH + 10.0f), floor(copyI/2) * (SMALLLISTHEIGHT+10.0f) + BIGLISTHEIGHT + 10.0f, SMALLLISTWIDTH, SMALLLISTHEIGHT) title:[[self.bean.list objectAtIndex:i] title] img:[[self.bean.list objectAtIndex:i] imgUrl] cornerable:YES];
        [cview set_id:[[self.bean.list objectAtIndex:i] _id]];
        cview.delegate = self;
        [view addSubview:cview];
        [cview release];
    }
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//更新scrollview的contentsize
-(void)updateScrollView:(UIScrollView*)scrollView
{
    int arrCount = [self.bean.list count];
    float height_scroll = BIGLISTHEIGHT + 10.0f + arrCount/2 * (SMALLLISTHEIGHT+10.0f);
    height_scroll = (height_scroll < scrollView.frame.size.height)? scrollView.frame.size.height + 1.0f:height_scroll;
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, height_scroll)];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat visibleTableDiffBoundsHeight = (self.scrollView.bounds.size.height - MIN(self.scrollView.bounds.size.height, self.scrollView.contentSize.height));
    CGRect loadMoreFrame = _refreshFooterView.frame;
    loadMoreFrame.origin.y = self.scrollView.contentSize.height + visibleTableDiffBoundsHeight;
    _refreshFooterView.frame = loadMoreFrame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
	// Do any additional setup after loading the view.
    if (_scrollView == nil) {
        _scrollView = [self creatTable];
        [self.view addSubview:_scrollView];
    }
    [self.view addSubview:tempIndicatorView];
    self.indicatorView = tempIndicatorView;
    self.bean = [LNconst httpRequestNewList:self.indicatorView];
    int arrCount = [self.bean.list count];
    NSLog(@"%d",arrCount);
    if (arrCount>0) {
        [self creatBig:_scrollView];
        [self creatSmall:_scrollView];
    }
    [self updateScrollView:_scrollView];
    if (_refreshHeaderView == nil) {
		NSLog(@"scrollView.bounds.size.height:%f",self.scrollView.bounds.size.height);
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, -self.scrollView.bounds.size.height, self.view.frame.size.width, self.scrollView.bounds.size.height)];
		view.delegate = self;
		[self.scrollView addSubview:view];
		_refreshHeaderView = view;
        //[view release];
	}
    if (_refreshFooterView == nil) {
        LoadMoreTableFooterView *footview = [[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0.0f, self.scrollView.bounds.size.height, self.view.frame.size.width, self.scrollView.bounds.size.height)];
        footview.delegate = self;
        [self.scrollView addSubview:footview];
        _refreshFooterView = footview;
        //[footview release];
    }
	[_scrollView release];
    [tempIndicatorView release];
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

#pragma mark - Status Propreties

@synthesize pullTableIsRefreshing;
@synthesize pullTableIsLoadingMore;

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    if(!pullTableIsRefreshing && isRefreshing) {
        // If not allready refreshing start refreshing
        [_refreshHeaderView startAnimatingWithScrollView:self.scrollView];
        pullTableIsRefreshing = YES;
    } else if(pullTableIsRefreshing && !isRefreshing) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
        pullTableIsRefreshing = NO;
    }
}

- (void)setPullTableIsLoadingMore:(BOOL)isLoadingMore
{
    if(!pullTableIsLoadingMore && isLoadingMore) {
        // If not allready loading more start refreshing
        [_refreshFooterView startAnimatingWithScrollView:self.scrollView];
        pullTableIsLoadingMore = YES;
    } else if(pullTableIsLoadingMore && !isLoadingMore) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
        pullTableIsLoadingMore = NO;
    }
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	pullTableIsRefreshing = YES;
	[_refreshFooterView egoRefreshScrollViewDidScroll:self.scrollView];
}

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	pullTableIsRefreshing = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	[_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return pullTableIsRefreshing; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - LoadMoreTableViewDelegate

- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    pullTableIsLoadingMore = YES;
    [self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:3.0];
}

- (void)dealloc
{
    [super dealloc];
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
    viewController.title = [view getTitle];
    [viewController updateId:view._id];
    [self.navigationController pushViewController:viewController animated:YES];
    [view setAlpha:1.0f];
    [viewController release];
}

@end
