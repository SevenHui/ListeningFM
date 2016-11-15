//
//  XQ_LiveRadiosModel.m
//  ListeningFM
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveRadiosModel.h"

@implementation XQ_LiveRadiosModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"name"]) {
        self.title = value;
    }
    if ([key isEqualToString:@"fmUid"]) {
        self.duration = value;
    }
    if ([key isEqualToString:@"playUrl"]) {
        self.playPathAacv224 = [value objectForKey:@"ts24"];
        self.aac24 = [value objectForKey:@"aac24"];
    }
}

@end
