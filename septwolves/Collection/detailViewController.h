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

@interface detailViewController : UIViewController<VideoViewDelegate,SliderDelegate,ASMediasFocusDelegate>
{
    NSMutableArray* imageArr;
    NSMutableArray* imageViews;
}
@property (nonatomic,retain) NSMutableArray *imageArr;
@property (nonatomic,retain) NSMutableArray *imageViews;
@property (nonatomic,retain) IBOutlet UIView *topView;
@property (nonatomic,retain) IBOutlet UILabel *textLabel;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UITextView *textView;


@end
