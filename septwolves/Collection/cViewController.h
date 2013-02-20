//
//  cViewController.h
//  septwolves
//
//  Created by 小才 on 13-2-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class cViewController;
@protocol cViewDelegate <NSObject>

@optional
- (void)touchEvent:(cViewController *)viewController;
@end
@interface cViewController : UIViewController
@property(nonatomic,assign) id<cViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame title:(NSString*)text img:(NSString*)url cornerable:(BOOL)cable;
@end
