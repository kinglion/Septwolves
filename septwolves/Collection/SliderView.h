//
//  SliderView.h
//  septwolves
//
//  Created by 小才 on 13-2-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol SliderDelegate

- (void)touchView:(UIImageView *)imageView;

@end

@interface SliderView : UIView<UIScrollViewDelegate>
{

}
-(CATransition *) getAnimation:(NSString *) direction;
- (id)initWithFrame:(CGRect)frame ImageArr:(NSMutableArray *)imageArr;
@property (nonatomic,assign) NSInteger imageCount;
@property (nonatomic,assign) NSInteger currentNum;
@property (nonatomic,assign) id<SliderDelegate> delegate;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIScrollView *scrollView;
@end
