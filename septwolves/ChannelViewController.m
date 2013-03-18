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

@interface ChannelViewController ()

@end

@implementation ChannelViewController
@synthesize channelTableView;
@synthesize channelLists;

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
    NSString *str = @"{\"resultCode\":\"0\",\"items\":[{\"id\":\"1\",\"imageUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"name\":\"新浪\",\"s_name\":\"社交好平台\",\"rssURl\":\"http://news.163.com/special/00011K6L/rss_newstop.xml\"},{\"id\":\"1\",\"imageUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"name\":\"新浪\",\"s_name\":\"社交好平台\",\"rssURl\":\"http://news.163.com/special/00011K6L/rss_newstop.xml\"},{\"id\":\"1\",\"imageUrl\":\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"name\":\"新浪\",\"s_name\":\"社交好平台\",\"rssURl\":\"http://news.163.com/special/00011K6L/rss_newstop.xml\"}]}";
    NSDictionary *data = [str objectFromJSONString];
    NSMutableArray *tempLists = [[NSMutableArray alloc]initWithArray:[data objectForKey:@"items"]];
    NSMutableArray *tempChannelLists = [[NSMutableArray alloc]init];
    for (NSDictionary *list in tempLists) {
        Channel *channel = [[Channel alloc]init];
        channel._id = [list objectForKey:@"id"];
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
	// Do any additional setup after loading the view.
}

- (UITableView *)createChannelTableView:(NSMutableArray *)lists
{
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT_MENU, WIDTH_SCREEN, HEIGHT_SUB_BAR - HEIGHT_MENU) style:UITableViewStylePlain];
    [tempTableView setDelegate:self];
    [tempTableView setDataSource:self];
    return tempTableView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.channelTableView){
        NSLog(@"选中！");
        [self.channelTableView deselectRowAtIndexPath:indexPath animated:YES];
        [UIView animateWithDuration:1 animations:^{
            [self.channelTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        }];
        isListOpen = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
