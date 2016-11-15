//
//  XQ_AnchorListModel.h
//  ListeningFM
//
//  Created by apple on 16/10/6.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseModel.h"

@interface XQ_AnchorListModel : XQ_BaseModel

@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, assign) NSInteger tracksCounts;
@property (nonatomic, assign) NSInteger followersCounts;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, copy) NSString *largeLogo;
@property (nonatomic, copy) NSString *middleLogo;
@property (nonatomic, copy) NSString *personDescribe;
@property (nonatomic, copy) NSString *verifyTitle;

@end
