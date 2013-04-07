//
//  ChrConsuViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ChrConsuView.h"
#import "LoadMoreTableFooterView.h"
#import "NewBean.h"
#import "LNActivityIndicatorView.h"
@interface ChrConsuViewController : UIViewController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate,ChrConsuViewDelegate,LoadMoreTableFooterDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    LoadMoreTableFooterView *_refreshFooterView;
    NSString *str;
    NSMutableArray *array;
    // Status
    BOOL pullTableIsRefreshing;
    BOOL pullTableIsLoadingMore;
    BOOL _reloading;
    LNActivityIndicatorView *indicatorView;
    NewBean *bean;
}
@property (nonatomic, assign) BOOL pullTableIsRefreshing;
@property (nonatomic, assign) BOOL pullTableIsLoadingMore;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic,retain) NewBean *bean;
@end
