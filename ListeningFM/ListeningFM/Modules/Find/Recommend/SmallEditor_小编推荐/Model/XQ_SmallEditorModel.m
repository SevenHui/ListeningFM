//
//  XQ_SmallEditorModel.m
//  ListeningFM
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SmallEditorModel.h"

@implementation XQ_SmallEditorModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"coverPathSmall"]) {
        self.coverPath = value;
    }
    if ([key isEqualToString:@"properties"]) {
        self.albumId = [[value objectForKey:@"albumId"] integerValue];
        self.key = [value objectForKey:@"key"];
        self.contentType = [value objectForKey:@"contentType"];
    }
    if ([key isEqualToString:@"id"]) {
        self.albumId = [value integerValue];
    }

    
    
    
}

@end
