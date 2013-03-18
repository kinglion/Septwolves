//
//  ChannelViewController.m
//  septwolves
//
//  Created by 小才 on 13-3-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ChannelViewController.h"
#import "LNconst.h"
#import "JSONKit.h"
#import "Channel.h"
#define HEIGHT_MENU 40.0f
#define WIDTH_LIST 120.0f
@interface ChannelViewController ()

@end

@implementation ChannelViewController
@synthesize channelTableView;
@synthesize channelLists;
@synthesize listTableView;


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *str = @"{\"resultCode\":\"0\",\"items\":[{\"id\":\"1\",\"imageUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"name\":\"新浪\",\"s_name\":\"社交好平台\",\"rssURl\":\"http://news.163.com/special/00011K6L/rss_newstop.xml\"},{\"id\":\"1\",\"imageUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"name\":\"新浪\",\"s_name\":\"社交好平台\",\"rssURl\":\"http://news.163.com/special/00011K6L/rss_newstop.xml\"},{\"id\":\"1\",\"imageUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"name\":\"新浪\",\"s_name\":\"社交好平台\",\"rssURl\":\"http://news.163.com/special/00011K6L/rss_newstop.xml\"}]}";
    NSDictionary *data = [str objectFromJSONString];
    NSMutableArray *tempLists = [[NSMutableArray alloc]initWithArray:[data objectForKey:@"items"]];
    NSMutableArray *tempChannelLists = [[NSMutableArray alloc]init];
    for (NSDictionary *list in tempLists) {
        Channel *channel = [[Channel alloc]init];
        channel._id = [[list objectForKey:@"id"] intValue];
        channel.imageUrl = [list objectForKey:@"imageUrl"];
        channel.name = [list objectForKey:@"name"];
        channel.s_name = [list objectForKey:@"s_name"];
        channel.rssUrl = [list objectForKey:@"rssUrl"];
        [tempChannelLists addObject:channel];
        [channel release];
    }
    self.channelLists = tempChannelLists;
    self.channelTableView = [self createChannelTableView:tempLists];
    [tempLists release];
    [tempChannelLists release];
    self.listTableView = [self creatListTableView];
    [self.view addSubview:self.channelTableView];
    [self.view addSubview:self.listTableView];
	// Do any additional setup after loading the view.
}

- (UITableView*)creatListTableView
{
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH_SCREEN - WIDTH_LIST, 0, WIDTH_LIST, HEIGHT_SUB_BAR) style:UITableViewStylePlain];
    [UIView animateWithDuration:1 animations:^{
        [tempTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
    }];
    isListOpen = NO;
    [tempTableView setDataSource:self];
    [tempTableView setDelegate:self];
    return tempTableView;
}

- (UITableView *)createChannelTableView:(NSMutableArray *)lists
{
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT_MENU, WIDTH_SCREEN, HEIGHT_SUB_BAR - HEIGHT_MENU) style:UITableViewStylePlain];
    [tempTableView setDelegate:self];
    [tempTableView setDataSource:self];
    return tempTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger length;
    if (tableView == self.listTableView) {
        length = 3;
    }else if(tableView == self.channelTableView){
        length = [channelLists count];
    }
    return length;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:1];
    self.listTableView.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    [cell.textLabel setFont:[UIFont fontWithName:@"黑体" size:20]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    self.listTableView.separatorColor = [UIColor darkGrayColor];
    [self.listTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.listTableView) {
        return 50;
    }else if(tableView == self.channelTableView){
        return 60;
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.channelTableView){
        NSLog(@"选中！");
        [self.channelTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cellldentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cellldentifier];
    if (cell == nil) {
        if (tableView == self.listTableView) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellldentifier]autorelease];
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的频道";
                    break;
                case 1:
                    cell.textLabel.text = @"我的收藏";
                    break;
                case 2:
                    cell.textLabel.text = @"订阅频道";
                    break;
                default:
                    break;
            }
        }else if(tableView == self.channelTableView){
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cellldentifier]autorelease];
            for (Channel *channel in self.channelLists) {
                cell.textLabel.text = channel.name;
                cell.detailTextLabel.text = channel.s_name;
            }
        }
    }
    return cell;
}


- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doClickListAction:(id)sender
{
    if (isListOpen) {
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        }];
        isListOpen = NO;
    }else{
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN - WIDTH_LIST, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        }];
        isListOpen = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
