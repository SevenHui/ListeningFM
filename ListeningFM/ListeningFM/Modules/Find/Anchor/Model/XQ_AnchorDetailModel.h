//
//  XQ_AnchorDetailModel.h
//  ListeningFM
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//  

#import "XQ_BaseModel.h"

@interface XQ_AnchorDetailModel : XQ_BaseModel

@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSNumber *albumId;
@property (nonatomic, retain) NSNumber *categoryId;
@property (nonatomic, retain) NSNumber *processState;
@property (nonatomic, retain) NSNumber *likes;
@property (nonatomic, retain) NSNumber *playtimes;
@property (nonatomic, retain) NSNumber *comments;
@property (nonatomic, copy) NSString *playPathAacv224;
@property (nonatomic, copy) NSString *playPathAacv164;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *coverMiddle;

@end
