//
//  LNSingleViewController.h
//  septwolves
//
//  Created by  Lion on 13-1-6.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBTableAlert.h"
#import "FPPopoverController.h"

@interface LNSingleViewController : UIViewController<FPPopoverControllerDelegate,SBTableAlertDataSource,SBTableAlertDelegate>
{
    UIPageControl *pageControl;
    UIScrollView *scrollView;
}
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@end
