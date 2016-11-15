//
//  XQArchiverTool.m
//  ListeningFM
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQArchiverTool.h"

@implementation XQArchiverTool

#pragma mark - 归档类方法
+ (void)archiverObject:(id)object ByKey:(NSString *)key WithPath:(NSString *)path{
    
    // 初始化存储对象信息的data
    NSMutableData *data = [NSMutableData data];
    // 创建归档的对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档
    [archiver encodeObject:object forKey:key];
    // 结束归档
    [archiver finishEncoding];
    // 写入本地
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    
    [data writeToFile:destPath atomically:YES];
    
}

#pragma mark - 返归档类方法
+ (id)unarchiverObjectByKey:(NSString *)key WithPath:(NSString *)path{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    NSData *data = [NSData dataWithContentsOfFile:destPath];
    // 创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 接收反归档得到的对象
    id object = [unarchiver decodeObjectForKey:key];
    return object;
    
}

@end
