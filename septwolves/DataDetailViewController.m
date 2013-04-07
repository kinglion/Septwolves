//
//  DataDetailViewController.m
//  septwolves
//
//  Created by 小才 on 13-3-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "DataDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#define HEIGHT_TABLE 235.0f
#define HEIGHT_IMG 170.0f
#define WIDTH_IMG 130.0f
#define WIDTH_DIS (WIDTH_SCREEN - 2 * WIDTH_IMG)/3 

@interface DataDetailViewController ()

@end

@implementation DataDetailViewController
@synthesize sql;
@synthesize mainTableView;
@synthesize themeLabel,addrLabel,externLabel,dateLabel;
@synthesize bean;
@synthesize indicatorView;
@synthesize imgBean;
@synthesize imgView;
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
        
        UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(doClickEditAction:)];
        [rightBarButtonItem setTintColor:[UIColor grayColor]];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [rightBarButtonItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    sql = [[LNSQLite alloc]init];
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_TABLE) style:UITableViewStyleGrouped];
    [tempTableView setDelegate:self];
    [tempTableView setDataSource:self];
    [self.view addSubview:tempTableView];
    self.mainTableView = tempTableView;
    [self.view addSubview:tempIndicatorView];
    self.indicatorView = tempIndicatorView;
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 175)];
    [self.view addSubview:tempView];
    self.imgView = tempView;
    [tempView release];
    [tempTableView release];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.sql) {
        self.bean = [sql selectSQLById:self.bean._id];
        [self.mainTableView reloadData];
        self.imgBean = [LNconst httpRequestAdviserList:self.indicatorView type:self.bean.type num:2];
        [self reloadImgView];
        NSLog(@"viewDidAppear");
    }
}

- (void)reloadImgView
{
    NSLog(@"item:%@",self.imgBean.item);
    if (self.imgView) {
        for (UIView *view in self.imgView.subviews) {
            [view removeFromSuperview];
        }
    }
    [self.imgView setFrame:CGRectMake(0, self.mainTableView.frame.size.height+10, 320, 175)];
    int length = [self.imgBean.item count];
    length = length > 2? 2 : length;
    for (int i = 0; i < length; i++) {
        float x = (i % 2) * (WIDTH_DIS + WIDTH_IMG) + WIDTH_DIS;
        float y = floor(i / 2) * HEIGHT_IMG;
        UIImageView *tempView = [self ImageViewOfURL:[[self.imgBean.item objectAtIndex:i] imgUrl] x:x y:y index:[[self.imgBean.item objectAtIndex:i] _id                                                                                                     ]];
        [self.imgView addSubview:tempView];
    }
}

- (UIImageView *)ImageViewOfURL:(NSString *)url x:(float)x y:(float)y index:(NSInteger)index
{
    UIImageView *tempView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, WIDTH_IMG, HEIGHT_IMG)];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, tempView.frame.size.width, tempView.frame.size.height)];
    [button setAlpha:1];
    [tempView addSubview:button];
    [button setTag:index];
    [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    [button setUserInteractionEnabled:YES];
    [tempView setUserInteractionEnabled:YES];
    [tempView setImageWithURL:[NSURL URLWithString:url]];
    [tempView.layer setBorderWidth:2];
    [tempView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [tempView.layer setShadowColor:[[UIColor grayColor] CGColor]];
    return tempView;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doClickEditAction:(id)sender
{
    DataAddViewController *addVc = [[DataAddViewController alloc]init];
    [addVc setBean:self.bean];
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)clickItem:(id)sender
{
    UIButton *button = sender;
    NSLog(@"touch:%d",button.tag);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.0];
    tableView.backgroundColor = altCellColor;
    tableView.backgroundView = nil;
    [tableView setBounces:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil) {
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                        cell.textLabel.text = @"主题";
                        UILabel *textLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 0, 200, 40)];
                        [textLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
                        textLabel.text = bean.title;
                        [cell.contentView addSubview: textLabel];
                        self.themeLabel = textLabel;
                        break;
                    case 1:
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                        cell.textLabel.text = @"地点";
                        textLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 0, 200, 40)];
                        [textLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
                        textLabel.text = bean.theme;
                        [cell.contentView addSubview: textLabel];
                        self.themeLabel = textLabel;
                        break;
                    case 2:
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                        cell.textLabel.text = @"时间";
                        textLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 0, 200, 40)];
                        [textLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
                        
                        NSTimeInterval time=[bean.timesp doubleValue];
                        NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:time];
                        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                        [formatter setDateFormat:@"HH:mm"];
                        NSString *timeStr = [formatter stringFromDate:timeDate];
                        textLabel.text = timeStr;

                        [cell.contentView addSubview: textLabel];
                        self.themeLabel = textLabel;
                        break;
                    default:
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form1"];
                        cell.textLabel.text = @"备注";
                        textLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 0, 200,40)];
                        [textLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
                        textLabel.text = bean.content;
                        [cell.contentView addSubview: textLabel];
                        self.themeLabel = textLabel;
                        break;
                }
                break;
            default:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"form2"];
                cell.textLabel.text = @"推荐搭配:";
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中！");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
