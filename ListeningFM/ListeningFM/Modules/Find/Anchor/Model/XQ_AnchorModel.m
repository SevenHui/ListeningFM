//
//  XQ_AnchorModel.m
//  ListeningFM
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AnchorModel.h"
#import "XQ_AnchorListModel.h"

@implementation XQ_AnchorModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"list"]) {
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            XQ_AnchorListModel *model = [[XQ_AnchorListModel alloc] initWithDic:dic];
            [self.listArray addObject:model];
        }
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
