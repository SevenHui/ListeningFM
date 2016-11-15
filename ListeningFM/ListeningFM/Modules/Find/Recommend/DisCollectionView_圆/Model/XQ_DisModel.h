//
//  XQ_DisModel.h
//  ListeningFM
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseModel.h"

@interface XQ_DisModel : XQ_BaseModel

@property (nonatomic, retain) NSNumber *albumId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *coverPath;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *cityTitle;

@end
