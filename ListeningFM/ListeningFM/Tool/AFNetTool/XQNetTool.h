//
//  XQNetTool.h
//  ListeningFM
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import <Foundation/Foundation.h>

// 成功回调
typedef void (^successBlock) (id result);
// 失败回调
typedef void (^failureBlock) (NSError *error);

// 响应模式
typedef NS_ENUM(NSUInteger, XQResponseStyle) {
    XQJSON,
    XQDATA,
    XQXML,
};
// 请求风格
typedef NS_ENUM(NSUInteger, XQRequestStyle) {
    XQBodyString,
    XQBodyJSON,
};

@interface XQNetTool : NSObject

+(void)GET:(NSString *)url
      Body:(id)body
HeaderFile:(NSDictionary *)headers
  Response:(XQResponseStyle)responseStyle
   Success:(successBlock)success
   Failure:(failureBlock)failure;

+(void)POST:(NSString *)url
       Body:(id)body
  BodyStyle:(XQRequestStyle)bodyStyle
 HeaderFile:(NSDictionary *)headers
   Response:(XQResponseStyle)responseStyle
    Success:(successBlock)success
    Failure:(failureBlock)failure;

@end
