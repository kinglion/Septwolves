//
//  cView.h
//  septwolves
//
//  Created by 小才 on 13-2-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cView : UIView
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)UILabel *label;
@property (nonatomic,assign)NSString *title;
@property (nonatomic,assign)NSString *img;
@property (nonatomic,assign)BOOL cornerable;
- (id)initWithFrame:(CGRect)frame title:(NSString*)text img:(NSString*)url cornerable:(BOOL)cable;
@end
