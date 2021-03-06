//
//  cView.h
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class cView;
@protocol cViewDelegate

@optional
- (void)touchEvent:(cView *)view;
@end
@interface cView : UIView
{
    NSString *title;
}
@property(nonatomic,assign) id <cViewDelegate> delegate;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)UILabel *label;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,assign)NSInteger _id;
@property (nonatomic,assign)BOOL cornerable;

- (void)setView:(CGRect)frame title:(NSString*)text img:(NSString*)url cornerable:(BOOL)cable;
- (NSString *)getTitle;
@end
