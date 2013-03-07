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

@interface LNSingleViewController : UIViewController<FPPopoverControllerDelegate,SBTableAlertDataSource,SBTableAlertDelegate,UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    UIScrollView *scrollView;
    NSString *str;
    NSArray *array;
    NSInteger currentNum;
}
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,copy) NSArray *array;
@property (nonatomic) NSInteger currentNum;
@end
