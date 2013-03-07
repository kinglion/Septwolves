//
//  LNSingleViewController.m
//  septwolves
//
//  Created by  Lion on 13-1-6.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNSingleViewController.h"
#import "FPPopoverController.h"
#import "JSONKit.h"

@interface LNSingleViewController ()

@property (nonatomic,assign) UIButton *tarBtn;

@end

@implementation LNSingleViewController
@synthesize tarBtn;
@synthesize pageControl;
@synthesize scrollView = _scrollView;
@synthesize array = _array;
@synthesize currentNum;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"西装服饰";
        [self.view setBackgroundColor:[UIColor blackColor]];
        //navigationBarItem
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


- (void)onClickPop:(id)sender
{
    NSLog(@"点击");
    SBTableAlert *alert	= [[SBTableAlert alloc] initWithTitle:nil cancelButtonTitle:@"Cancel" messageFormat:nil];
    [alert setType:SBTableAlertTypeMultipleSelct];
    [alert.view addButtonWithTitle:@"OK"];
    [alert setDelegate:self];
	[alert setDataSource:self];
	[alert show];
    [alert release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    currentNum = 1;
    str = @"{\"result\":\"000\", \"imgArr\":[\"http://img.itc.cn/photo/jejJ6dJCVWW\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\"]}";
    NSDictionary *data = [str objectFromJSONString];
    _array = [data objectForKey:@"imgArr"];
    int arrCount = [_array count];
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [_scrollView setUserInteractionEnabled:YES];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setDelegate:self];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width * arrCount, self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    for (int i = 0; i < arrCount; i++) {
        UIImage *image = [UIImage imageNamed:@"man1.png"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [imageView setFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [_scrollView addSubview:imageView];
        [imageView setUserInteractionEnabled:YES];
        //生成触摸点
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"03.png"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(self.view.frame.size.width - 74,10, 64, 64)];
        [button addTarget:self action:@selector(onClickPop:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        [imageView release];
        //[button release];
        //
        //[image release];
    }
    
    // Custom initialization
    //addSubView UIpageControl
    pageControl = [[UIPageControl alloc]init];
    [pageControl setCurrentPage:0];
    [pageControl setNumberOfPages:arrCount];
    [pageControl setFrame:CGRectMake((self.view.frame.size.width - pageControl.frame.size.width)*0.5,self.view.frame.size.height - 30.0f,16*(arrCount-1)+16,16)];
    [pageControl setCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 40.0f)];
    [pageControl setBounds:CGRectMake(0,0,16*(arrCount-1)+16,16)]; //页面控件上的圆点间距基本在16左右。
    [pageControl setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    [pageControl.layer setCornerRadius:8]; // 圆角层
    [self.view addSubview:pageControl];
    [_scrollView release];
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)ascrollView
{
	CGFloat pageWidth = ascrollView.bounds.size.width ;
    float fractionalPage = ascrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (ascrollView.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SBTableAlertDelegate

- (void)tableAlert:(SBTableAlert *)tableAlert didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableAlert.type == SBTableAlertTypeMultipleSelct) {
		UITableViewCell *cell = [tableAlert.tableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone)
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		else
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		
		[tableAlert.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"Dismissed: %i", buttonIndex);
	
	[tableAlert release];
}

#pragma mark - SBTableAlertDataSource

- (UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	if (tableAlert.view.tag == 0 || tableAlert.view.tag == 1) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	} else {
		// Note: SBTableAlertCell
		cell = [[[SBTableAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
	}
	
	[cell.textLabel setText:[NSString stringWithFormat:@"Cell %d", indexPath.row]];
	
	return cell;
}

- (NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section {
	if (tableAlert.type == SBTableAlertTypeSingleSelect)
		return 3;
	else
		return 10;
}

- (NSInteger)numberOfSectionsInTableAlert:(SBTableAlert *)tableAlert {
	if (tableAlert.view.tag == 3)
		return 2;
	else
		return 1;
}

- (NSString *)tableAlert:(SBTableAlert *)tableAlert titleForHeaderInSection:(NSInteger)section {
	if (tableAlert.view.tag == 3)
		return [NSString stringWithFormat:@"Section Header %d", section];
	else
		return nil;
}



@end
