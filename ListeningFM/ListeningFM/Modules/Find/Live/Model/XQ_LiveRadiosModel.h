//
//  XQ_LiveRadiosModel.h
//  ListeningFM
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseModel.h"

@interface XQ_LiveRadiosModel : XQ_BaseModel

@property (nonatomic, retain) NSNumber *ID;
@property (nonatomic, retain) NSNumber *duration;
@property (nonatomic, retain) NSNumber *programId;
@property (nonatomic, retain) NSNumber *programScheduleId;
@property (nonatomic, retain) NSNumber *playCount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, copy) NSString *programName;
@property (nonatomic, copy) NSString *playPathAacv224;
@property (nonatomic, copy) NSString *aac24;

@end
