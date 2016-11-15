//
//  XQ_SQLiteTool.h
//  ListeningFM
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "XQ_SmallEditorModel.h"
@interface XQ_SQLiteTool : NSObject
{
    sqlite3 *DBPoint;
}
// 单列
+ (XQ_SQLiteTool *)shareInstance;
// 打开数据库
- (void)openDB;
// 关闭数据库
- (void)closeDB;
// 插入数据
- (void)insert:(XQ_SmallEditorModel *)model;
// 创建表
- (void)createTable;
// 查询所有
- (NSArray *)selectAll;
// 是否收藏
- (BOOL)isCollectedInTableadS:(NSInteger)albumId;
// 删除数据
- (void)deleteDataWithModel:(NSInteger)intStr;
// 删除全部数据
- (void)removeAllData;

@end
