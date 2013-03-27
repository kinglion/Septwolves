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
#import "LNActivityIndicatorView.h"
#import "CharacterBean.h"
#import "LNconst.h"
@interface LNSingleViewController : UIViewController<FPPopoverControllerDelegate,SBTableAlertDataSource,SBTableAlertDelegate,UIScrollViewDelegate>
{
    LNActivityIndicatorView *indicatorView;
    UIPageControl *pageControl;
    UIScrollView *scrollView;
    NSString *str;
    NSArray *array;
    NSInteger currentNum;
    NSInteger type_id;
    CharacterBean *bean;
}
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,copy) NSArray *array;
@property (nonatomic) NSInteger currentNum;
@property (nonatomic,assign) NSInteger type_id;
@property (nonatomic,retain) CharacterBean *bean;
- (id)init:(NSInteger)typeid;
@end
