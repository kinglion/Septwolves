//
//  ActiveViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cView.h"
#import "EGORefreshTableHeaderView.h"

@interface ActiveViewController : UIViewController<UIScrollViewDelegate,cViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@property (nonatomic,retain)UIScrollView *scrollView;
@end
