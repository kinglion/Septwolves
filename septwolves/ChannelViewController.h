//
//  ChannelViewController.h
//  septwolves
//
//  Created by 小才 on 13-3-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *channelTableView;
    NSMutableArray *channelLists;
    NSMutableArray *typeLists;
    UITableView *typeTableView;
    UILabel *selectLabel;
    BOOL isListOpen;
    BOOL isMenuOpen;
    UITableView *listTableView;
}
@property (nonatomic,retain) UITableView *channelTableView;
@property (nonatomic,retain) NSMutableArray *channelLists;
@property (nonatomic,retain) UITableView *listTableView;
@property (nonatomic,retain) UITableView *typeTableView;
@property (nonatomic,retain) NSMutableArray *typeLists;
@property (nonatomic,retain) UILabel *selectLabel;
@end
