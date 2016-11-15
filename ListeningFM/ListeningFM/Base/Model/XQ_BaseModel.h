//
//  XQ_BaseModel.h
//  ListeningFM
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQ_BaseModel : NSObject

/**基类初始化方法*/
- (instancetype)initWithDic:(NSDictionary *)dic;

/**基类构造器方法*/
+ (instancetype)XQ_BaseModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

