//
//  XQ_DisModel.m
//  ListeningFM
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_DisModel.h"

@implementation XQ_DisModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"properties"]) {
        self.contentType = [value objectForKey:@"contentType"];
        self.albumId = [value objectForKey:@"albumId"];
        self.key = [value objectForKey:@"key"];
        self.cityCode = [value objectForKey:@"cityCode"];
        self.cityTitle = [value objectForKey:@"cityTitle"];
    }
}

@end
