//
//  XQ_CategoryModel.h
//  ListeningFM
//
//  Created by apple on 16/9/24.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseModel.h"

@interface XQ_CategoryModel : XQ_BaseModel

@property (nonatomic, retain) NSNumber *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverPath;
@property (nonatomic, retain) NSNumber *orderNum;
@property (nonatomic, copy) NSString *contentType;

@end
