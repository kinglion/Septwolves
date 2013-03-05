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
    NSInteger type;
    NSString* content;
}
@property(nonatomic,copy) NSString *title, *imgUrl;
@property(nonatomic,copy) NSString *content;
@property(nonatomic)NSInteger type;
@property(nonatomic)NSInteger productId;
+ (id)productWithType:(NSInteger)proId title:(NSString*)text imgUrl:(NSString*)url type:(NSInteger)typeId;
@end
