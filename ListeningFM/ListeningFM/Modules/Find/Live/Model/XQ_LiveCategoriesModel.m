//
//  XQ_LiveCategoriesModel.m
//  ListeningFM
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveCategoriesModel.h"

@implementation XQ_LiveCategoriesModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
