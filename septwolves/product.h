//
//  product.h
//  septwolves
//
//  Created by 小才 on 13-3-1.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface product : NSObject
{
    NSInteger productId;
    NSString* title;
    NSString* imgUrl;
    NSInteger* type;
}
@property(nonatomic,copy) NSString *title, *imgUrl;
@end
