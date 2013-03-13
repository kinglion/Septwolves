//
//  SliderView.m
//  septwolves
//
//  Created by 小才 on 13-2-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "SliderView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation SliderView

@synthesize pageControl = _pageControl;
@synthesize scrollView = _scrollView;
@synthesize delegate = _delegate;
@synthesize imageCount,currentNum;
@synthesize images;
@synthesize mediaFocusManager;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)setFrame:(CGRect)frame ImageArr:(NSMutableArray *)imageArr

{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imgArr = [[NSMutableArray alloc]init];
        self.mediaFocusManager = [[ASMediaFocusManager alloc] init];
        currentNum = 0;
        imageCount = [imageArr count];
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = currentNum;
        _pageControl.numberOfPages = imageCount;
        [_pageControl setCenter:CGPointMake(self.center.x, self.bounds.size.height - 20.0f)];
        [_pageControl setBounds:CGRectMake(0,0,16*(imageCount-1)+16,16)]; //页面控件上的圆点间距基本在16左右。
        [_pageControl.layer setCornerRadius:8]; // 圆角层
        [_pageControl setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]]; 
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [_scrollView setContentSize: CGSizeMake(_scrollView.bounds.size.width * imageCount, _scrollView.bounds.size.height)];
        _scrollView.delegate = self;
        [_scrollView setBounces:NO];
        [_scrollView setPagingEnabled: YES];
        CGRect pageFrame;
        UIImageView *imageView;
        for (int i = 0 ; i < imageCount ; i++)
        {
            pageFrame = CGRectMake(i * _scrollView.bounds.size.width, 0.0f, _scrollView.bounds.size.width, _scrollView.bounds.size.height) ;
            imageView = [[UIImageView alloc]init];
            [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]]];
            [imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView setFrame:pageFrame];
            [imgArr addObject:imageView];
            [self.scrollView addSubview:imageView];
            [imageView release];
        }
        self.images = imgArr;
        [self.mediaFocusManager installOnViews:self.images];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        [_delegate touchView:self ASMediaFocusManager:self.mediaFocusManager images:imgArr];
        [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        [_scrollView release];
        [_pageControl release];
        [imageArr release];
        [imgArr release];
    }
    return self;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
  //  int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    //_pageControl.currentPage = index;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = scrollView.bounds.size.width ;
    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (_pageControl.currentPage != nearestNumber)
	{
		_pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (scrollView.dragging)
			[_pageControl updateCurrentPageDisplay] ;
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[_pageControl updateCurrentPageDisplay] ;
}

- (void)pageTurn:(id)sender
{
    NSLog(@"sss");
    CATransition *transition;
    int secondPage = [_pageControl currentPage];
    if((secondPage - currentNum)>0)
        transition = [self getAnimation:@"fromRight"];
    else
        transition = [self getAnimation:@"fromLeft"];
    
    [_scrollView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [[_scrollView layer] addAnimation:transition forKey:@"transitionView Animation"];
    
    currentNum = [_pageControl currentPage];
}

-(CATransition *) getAnimation:(NSString *) direction

{
    
    CATransition *animation = [CATransition animation];
    
    [animation setDelegate:self];
    
    [animation setType:kCATransitionPush];
    
    [animation setSubtype:direction];
    
    [animation setDuration:1.0f];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    return animation;
    
}


#pragma mark - touchView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
