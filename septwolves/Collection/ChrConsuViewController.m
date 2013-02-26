//
//  ChrConsuViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//  名士资讯

#import "ChrConsuViewController.h"
#import "JSONKit.h"

@interface ChrConsuViewController ()

@end

@implementation ChrConsuViewController
@synthesize scrollView = _scrollView;

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
    str = @"{\"list\":[{\"id\":123,\"name\":\"《李安》\" \"imgArr\":[\"http://img.itc.cn/photo/jejJ6dJCVWW\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T963K.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95D6.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96048.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T921E.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T954410.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tca11.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132U012312.jpg\"]},{\"id\":123,\"name\":\"《李安》\" \"imgArr\":[\"http://img.itc.cn/photo/jejJ6dJCVWW\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T963K.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95D6.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96048.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T921E.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T954410.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tca11.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132U012312.jpg\"]}]}";
    NSDictionary *data = [str objectFromJSONString];
    array = [NSMutableArray arrayWithArray:[data objectForKey:@"list"]];
    _scrollView = [self creatTable];
    int arrCount = [array count];
    if (arrCount > 0) {
        
    }
	// Do any additional setup after loading the view.
}

//创建外围scrollView
-(UIScrollView*)creatTable
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setDelegate:self];
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}

//

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
