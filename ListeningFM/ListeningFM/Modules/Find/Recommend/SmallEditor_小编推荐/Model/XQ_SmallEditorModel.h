//
//  XQ_SmallEditorModel.h
//  ListeningFM
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//  小编推荐Model & 精品听单Model

#import "XQ_BaseModel.h"

@interface XQ_SmallEditorModel : XQ_BaseModel
#pragma mark - 小编推荐
@property (nonatomic, retain) NSNumber *ID;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSNumber *trackId;
@property (nonatomic, retain) NSNumber *tracks;
@property (nonatomic, retain) NSNumber *playsCounts;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *albumCoverUrl290;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *trackTitle;
#pragma mark - 轮播图
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, copy) NSString *shortTitle;
@property (nonatomic, copy) NSString *longTitle;
@property (nonatomic, copy) NSString *pic;
#pragma mark - 精品听单
@property (nonatomic, retain) NSNumber *columnType;
@property (nonatomic, retain) NSNumber *specialId;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSNumber *playtimes;
@property (nonatomic, retain) NSNumber *comments;
@property (nonatomic, retain) NSNumber *releasedAt;
@property (nonatomic, retain) NSNumber *favoritesCounts;
@property (nonatomic, retain) NSNumber *commentsCounts;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *footnote;
@property (nonatomic, copy) NSString *coverPath;
@property (nonatomic, copy) NSString *playUrl64;
@property (nonatomic, copy) NSString *playUrl32;
@property (nonatomic, copy) NSString *playPathAacv164;
@property (nonatomic, copy) NSString *playPathAacv224;
@property (nonatomic, copy) NSString *tracksCounts;
@property (nonatomic, copy) NSString *coverPathBig;
@property (nonatomic, copy) NSString *playPath64;
#pragma mark - 热门推荐
@property (nonatomic, retain) NSNumber *categoryId;
@property (nonatomic, retain) NSNumber *keywordId;
@property (nonatomic, retain) NSNumber *commentsCount;
@property (nonatomic, retain) NSNumber *priceTypeId;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSNumber *discountedPrice;
@property (nonatomic, retain) NSNumber *score;
@property (nonatomic, retain) NSNumber *priceTypeEnum;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *keywordName;
@property (nonatomic, copy) NSString *displayPrice;
#pragma mark - 听大连
@property (nonatomic, copy) NSString *name;
#pragma mark - 订阅推荐
@property (nonatomic, retain) NSNumber *lastUptrackAt;
@property (nonatomic, retain) NSNumber *lastUptrackId;
@property (nonatomic, retain) NSNumber *serialState;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *lastUptrackTitle;
@property (nonatomic, copy) NSString *recReason;

@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *keyword;

@end
