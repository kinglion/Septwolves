//
//  LNShakeView.h
//  septwolves
//
//  Created by 小才 on 13-3-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LNShakeView;
@protocol LNShakeViewDelegate
- (void)shakeAnimateFinished:(LNShakeView *)target;
- (void)pullAnimateFinished:(LNShakeView *)target;
- (void)pushAnimateFinished:(LNShakeView *)target;
@end
@interface LNShakeView : UIView
{
    NSArray *lists;
}
@property (nonatomic,retain) NSArray *lists;
@property(nonatomic,assign) id <LNShakeViewDelegate> delegate;
- (void)shake;
- (void)pull;
- (void)push;
- (void)setImageDate:(NSArray *)imageList;
@end
