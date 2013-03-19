//
//  LNSQLite.m
//  septwolves
//
//  Created by 小才 on 13-3-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNSQLite.h"

@implementation LNSQLite
@synthesize dbHandle;
- (id)init
{
    self = [super init];
    if (self) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@",path);
        path = [path stringByAppendingString:@"/"];
        NSString *file = [path stringByAppendingString:SQL_NAME];
        if([[NSFileManager defaultManager]fileExistsAtPath:file] == FALSE){
            [[NSFileManager defaultManager]createFileAtPath:file contents:nil attributes:nil];
        }
        if (sqlite3_open([file UTF8String], &dbHandle) != SQLITE_OK) {
            NSAssert1(0, @"无法打开数据库%s", sqlite3_errmsg(dbHandle));
        }
    }
    return self;
}

- (NSMutableArray *)selectSQLAll
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    return tempArray;
}

- (void)dealloc
{
    sqlite3_close(dbHandle);
    [super dealloc];
}
@end
