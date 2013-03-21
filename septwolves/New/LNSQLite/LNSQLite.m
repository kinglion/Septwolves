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
        isFrist = false;
        NSString *file = [path stringByAppendingString:SQL_NAME];
        if([[NSFileManager defaultManager]fileExistsAtPath:file] == FALSE){
            [[NSFileManager defaultManager]createFileAtPath:file contents:nil attributes:nil];
            isFrist = true;
        }
        if (sqlite3_open([file UTF8String], &dbHandle) != SQLITE_OK) {
            NSAssert1(0, @"无法打开数据库%s", sqlite3_errmsg(dbHandle));
        }else{
            if (isFrist) {
                char *errorMsg;
                const char *createSql="create table if not exists Adviser (id integer primary key autoincrement,title text,type integer,theme text,content text,time text)";
                
                if (sqlite3_exec(dbHandle, createSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
                    NSLog(@"create ok.");
                    isFrist = NO;
                }else {
                    NSLog(@"error: %s",errorMsg);
                    sqlite3_free(errorMsg);
                }
            }
        }
    }
    return self;
}

- (NSMutableArray *)selectSQLAll
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    const char *selectSql = "select * from Adviser";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(dbHandle, selectSql, -1, &statement, nil)==SQLITE_OK) {
        NSLog(@"select ok.");
    }
    
    while (sqlite3_step(statement)==SQLITE_ROW) {
        dataBean *bean = [[dataBean alloc]init];
        int _idInt=sqlite3_column_int(statement, 0);
        char *titleChar=(char *)sqlite3_column_text(statement, 1);
        int typeInt = sqlite3_column_int(statement, 2);
        char *themeChar = (char *)sqlite3_column_text(statement, 3);
        char *contentChar = (char *)sqlite3_column_text(statement, 4);
        char *timeChar = (char *)sqlite3_column_text(statement, 5);
        bean._id = _idInt;
        bean.title = [[NSString alloc]initWithUTF8String:titleChar];
        bean.type = &(typeInt);
        bean.theme = [[NSString alloc]initWithUTF8String:themeChar];
        bean.content = [[NSString alloc]initWithUTF8String:contentChar];
        bean.timesp = [[NSString alloc]initWithUTF8String:timeChar];
        [tempArray addObject:bean];
        NSLog(@"row>>id %i, title %s,type %i,theme %s,content %s,time %s",_idInt,titleChar,typeInt,themeChar,contentChar,timeChar);
    }
    
    sqlite3_finalize(statement);
    return tempArray;
}

- (void)updateSQLByItem:(NSInteger)_id theme:(NSString *)theme type:(NSInteger)type addr:(NSString *)addr content:(NSString *)content time:(NSString *)time
{
    if (self.dbHandle) {
        char *errorMsg;
        NSString *updateStr = [NSString stringWithFormat:@"update Adviser set title='%@',type='%d',theme='%@',content='%@',time='%@' WHERE id='%d'",theme,type,addr,content,time,_id];
        const char *updateSql = [updateStr UTF8String];
        if (sqlite3_exec(dbHandle, updateSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
            NSLog(@"update ok.");
        }else {
            NSLog(@"error: %s",errorMsg);
            sqlite3_free(errorMsg);
        }
    }
}

- (void)insertSQLByItem:(NSString *)theme type:(NSInteger)type addr:(NSString *)addr content:(NSString *)content time:(NSString *)time
{
    if (self.dbHandle) {
        char *errorMsg;
        NSString *insertStr = [NSString stringWithFormat:@"insert into Adviser (title,type,theme,content,time) values('%@','%d','%@','%@','%@')",theme,type,addr,content,time];
        const char *insertSql = [insertStr UTF8String];
        if (sqlite3_exec(dbHandle, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
            NSLog(@"insert ok.");
        }else {
            NSLog(@"error: %s",errorMsg);
            sqlite3_free(errorMsg);
        }
        
    }
}

- (void)dealloc
{
    sqlite3_close(dbHandle);
    [super dealloc];
}
@end
