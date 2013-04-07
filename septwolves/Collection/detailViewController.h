//
//  detailViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoView.h"
#import "SliderView.h"
#import "ASMediaFocusManager.h"
#import "NewBean.h"
#import "LNconst.h"
#import "LNActivityIndicatorView.h"

@interface detailViewController : UIViewController<VideoViewDelegate,SliderDelegate,ASMediasFocusDelegate>
{
    NSMutableArray* imageArr;
    NSMutableArray* imageViews;
    NSInteger _id;
    NewBean *bean;
    LNActivityIndicatorView *indicatorView;
}
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (assign) NSInteger _id;
@property (nonatomic,retain) NewBean *bean;
@property (nonatomic,retain) NSMutableArray *imageArr;
@property (nonatomic,retain) NSMutableArray *imageViews;
@property (nonatomic,retain) IBOutlet UIView *topView;
@property (nonatomic,retain) IBOutlet UILabel *textLabel;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UIWebView *textView;
- (void)updateId:(NSInteger)newID;

@end
