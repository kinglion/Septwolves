//
//  SliderView.h
//  septwolves
//
//  Created by 小才 on 13-2-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASMediaFocusManager.h"
@protocol SliderDelegate

- (void)touchView:(UIImageView *)imageView;

@end

@interface SliderView : UIView<UIScrollViewDelegate,ASMediasFocusDelegate>
{
    NSMutableArray *images;
    ASMediaFocusManager *mediaFocusManager;
}
-(CATransition *) getAnimation:(NSString *) direction;
- (id)initWithFrame:(CGRect)frame ImageArr:(NSMutableArray *)imageArr;
@property (strong, nonatomic) ASMediaFocusManager *mediaFocusManager;
@property (nonatomic,assign) NSInteger imageCount;
@property (nonatomic,assign) NSInteger currentNum;
@property (nonatomic,assign) id<SliderDelegate> delegate;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) NSMutableArray *images;
@end
