//
//  LNConsuViewController.m
//  septwolves
//
//  Created by  Lion on 13-3-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNConsuViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define IMAGE_DIS_TOP_AND_BOTTOM 20.0f
#define IMAGE_DIS_LEFT_AND_RIGHT 20.0f

@interface LNConsuViewController ()

@end

@implementation LNConsuViewController
@synthesize mainScrollView;
@synthesize listTableView;
@synthesize pageLabel;

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
        [backImage release];
        
        UIImage* listImage = [UIImage imageNamed:@"right_item_bg.png"];
        CGRect listframe = CGRectMake(0, 0, 20, 18);
        UIButton *listButton = [[UIButton alloc]initWithFrame:listframe];
        [listButton setBackgroundImage:listImage forState:UIControlStateNormal];
        [listButton setTitle:@"" forState:UIControlStateNormal];
        listButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [listButton addTarget:self action:@selector(doClickListAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:listButton];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [rightBarButtonItem release];
        [listButton release];
        [listImage release];
    }
    return self;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doClickListAction:(id)sender
{
    
}

- (UIScrollView *)creatImageScroll:(NSMutableArray *)images
{
    int imagesCount = [images count];
    UIScrollView *tempScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tempScroll setContentSize:CGSizeMake(self.view.frame.size.width * imagesCount, self.view.frame.size.height)];
    int index = 0;
    for (NSString* url in images) {
        UIImageView *tempImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(IMAGE_DIS_LEFT_AND_RIGHT + index *self.view.frame.size.width, IMAGE_DIS_TOP_AND_BOTTOM, self.view.frame.size.width - 2*IMAGE_DIS_LEFT_AND_RIGHT, self.view.frame.size.height - 2*IMAGE_DIS_TOP_AND_BOTTOM)] autorelease];
        [tempImageView setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error) {
                NSLog(@"some thing worry!must be happened");
            }
        }];
        [tempImageView setContentMode:UIViewContentModeScaleAspectFit];
        [tempScroll addSubview:tempImageView];
        index++;
    }
    [tempScroll setPagingEnabled:YES];
    return tempScroll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *images = [[NSMutableArray alloc]initWithObjects:@"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg",@"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg", nil];
    self.mainScrollView = [self creatImageScroll:images];
    [self.view addSubview:self.mainScrollView];
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(IMAGE_DIS_LEFT_AND_RIGHT, self.view.frame.size.height - IMAGE_DIS_TOP_AND_BOTTOM + 5, self.view.frame.size.width - 2*IMAGE_DIS_LEFT_AND_RIGHT, 20.0f)];
    NSLog(@"%f,%f,%f,%f",IMAGE_DIS_LEFT_AND_RIGHT,self.view.frame.size.height - IMAGE_DIS_TOP_AND_BOTTOM + 5,self.view.frame.size.width - 2*IMAGE_DIS_LEFT_AND_RIGHT,20.0f);
    tempLabel.text = [NSString stringWithFormat:@"%d / %d",1,[images count]];
    [tempLabel setTextColor:[UIColor whiteColor]];
    [tempLabel setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:tempLabel];
    self.pageLabel = tempLabel;
    [tempLabel release];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
