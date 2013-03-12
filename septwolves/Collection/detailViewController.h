//
//  detailViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoView.h"

@interface detailViewController : UIViewController<VideoViewDelegate>

@property (nonatomic,retain) IBOutlet UIView *topView;
@property (nonatomic,retain) IBOutlet UILabel *textLabel;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UITextView *textView;

@end
