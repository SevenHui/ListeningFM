//
//  XQ_HotRecModel.h
//  ListeningFM
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseModel.h"

@interface XQ_HotRecModel : XQ_BaseModel

@property (nonatomic, assign) NSNumber *categoryId;
@property (nonatomic, retain) NSNumber *categoryType;
@property (nonatomic, retain) NSNumber *count;
@property (nonatomic, retain) NSNumber *keywordId;
@property (nonatomic, retain) NSNumber *ID;
@property (nonatomic, retain) NSMutableArray *arrayList;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *keywordName;
@property (nonatomic, copy) NSString *coverPath;

@end
