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
@interface ChrConsuViewController : UIViewController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate,ChrConsuViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSString *str;
    NSMutableArray *array;
    BOOL _reloading;
}
@property (nonatomic,retain)UIScrollView *scrollView;
@end
