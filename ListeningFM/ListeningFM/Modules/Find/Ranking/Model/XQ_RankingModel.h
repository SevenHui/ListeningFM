//
//  XQ_RankingModel.h
//  ListeningFM
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseModel.h"

@interface XQ_RankingModel : XQ_BaseModel

@property (nonatomic, retain) NSNumber *rankingListId;
@property (nonatomic, retain) NSNumber *firstId;
@property (nonatomic, retain) NSNumber *followersCounts;
@property (nonatomic, retain) NSNumber *tracksCounts;
@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *personDescribe;
@property (nonatomic, copy) NSString *verifyTitle;
@property (nonatomic, copy) NSString *middleLogo;
@property (nonatomic, copy) NSString *coverPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *rankingRule;
@property (nonatomic, copy) NSString *firstTitle;
@property (nonatomic, copy) NSString *calcPeriod;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *firstKResults;

@end
