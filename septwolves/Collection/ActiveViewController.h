//
//  ActiveViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "cView.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"

@interface ActiveViewController : UIViewController<cViewDelegate,EGORefreshTableHeaderDelegate,LoadMoreTableFooterDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    LoadMoreTableFooterView *_refreshFooterView;
    // Status
    BOOL pullTableIsRefreshing;
    BOOL pullTableIsLoadingMore;
    NSString *str;
}
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@property (nonatomic, assign) BOOL pullTableIsRefreshing;
@property (nonatomic, assign) BOOL pullTableIsLoadingMore;
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)NSMutableArray *array;
@end
