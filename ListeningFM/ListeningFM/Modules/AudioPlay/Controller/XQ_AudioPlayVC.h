//
//  XQ_AudioPlayVC.h
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseViewController.h"
@class XQ_SmallEditorModel;
@interface XQ_AudioPlayVC : XQ_BaseViewController

@property (nonatomic, retain) XQ_SmallEditorModel *model;
/**变量下标*/
@property (nonatomic, assign) NSInteger index;
/**数据数组*/
@property (nonatomic, retain) NSArray *musicArr;

#pragma mark - 单例
+ (XQ_AudioPlayVC *)shareDetailViewController;

@end
