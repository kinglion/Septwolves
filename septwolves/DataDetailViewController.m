//
//  DataDetailViewController.m
//  septwolves
//
//  Created by 小才 on 13-3-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "DataDetailViewController.h"
#define HEIGHT_TABLE 300.0f

@interface DataDetailViewController ()

@end

@implementation DataDetailViewController
@synthesize sql;
@synthesize mainTableView;
@synthesize themeLabel,addrLabel,externLabel,dateLabel;
@synthesize bean;
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
    sql = [[LNSQLite alloc]init];
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_TABLE) style:UITableViewStyleGrouped];
    [tempTableView setDelegate:self];
    [tempTableView setDataSource:self];
    [self.view addSubview:tempTableView];
    self.mainTableView = tempTableView;
    [tempTableView release];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.sql) {
        self.bean = [sql selectSQLById:self.bean._id];
        [self.mainTableView reloadData];
    }
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
