//
//  LNSQLite.h
//  septwolves
//
//  Created by 小才 on 13-3-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#define SQL_NAME @"septwolves.db"

@interface LNSQLite : NSObject
{
    sqlite3 *dbHandle;
}
@property (nonatomic) sqlite3 *dbHandle;
- (NSMutableArray *)selectSQLAll;
@end
