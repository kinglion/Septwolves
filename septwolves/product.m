//
//  product.m
//  septwolves
//
//  Created by 小才 on 13-3-1.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "product.h"

@implementation product
@synthesize title,imgUrl,productId,type;

+ (id)productWithType:(NSInteger)proId title:(NSString*)text imgUrl:(NSString*)url type:(NSInteger)typeId
{
	product *newProduct = [[[self alloc] init] autorelease];
	newProduct.productId = proId;
	newProduct.title = text;
    newProduct.imgUrl = url;
    newProduct.type = typeId;
	return newProduct;
}

-(void)dealloc
{
    [super dealloc];
    [title release];
    [imgUrl release];
}


@end
