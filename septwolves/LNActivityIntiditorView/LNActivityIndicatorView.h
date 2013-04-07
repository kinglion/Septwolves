//
//  LNActivityInditorView.h
//  septwolves
//
//  Created by 小才 on 13-3-15.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNActivityIndicatorView : UIView
{
    UIActivityIndicatorView *indicatorView;
    UIView *coverView;
}
@property (nonatomic,retain) UIActivityIndicatorView *indicatorView;
@property (nonatomic,retain) UIView *coverView;
- (void)startAnimating;
- (void)stopAnimating;
@end
