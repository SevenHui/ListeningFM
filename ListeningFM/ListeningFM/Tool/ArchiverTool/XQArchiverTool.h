//
//  XQArchiverTool.h
//  ListeningFM
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQArchiverTool : NSObject

// 归档类方法
+ (void)archiverObject:(id)object ByKey:(NSString *)key
              WithPath:(NSString *)path;
// 返归档类方法
+ (id)unarchiverObjectByKey:(NSString *)key
                   WithPath:(NSString *)path;

@end
