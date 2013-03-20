//
//  LNSQLite.h
//  septwolves
//
//  Created by 小才 on 13-3-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "dataBean.h"
#define SQL_NAME @"septwolves.db"

@interface LNSQLite : NSObject
{
    sqlite3 *dbHandle;
    BOOL isFrist;
}
@property (nonatomic) sqlite3 *dbHandle;
- (NSMutableArray *)selectSQLAll;
- (void)updateSQLByItem:(NSInteger)_id title:(NSString *)title type:(NSInteger)type theme:(NSString *)theme content:(NSString *)content time:(NSString *)time;
- (void)insertSQLByItem:(NSString *)title type:(NSInteger)type theme:(NSString *)theme content:(NSString *)content time:(NSString *)time;
@end
