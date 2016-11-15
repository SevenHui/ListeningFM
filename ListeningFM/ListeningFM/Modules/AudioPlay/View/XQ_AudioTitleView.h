//
//  XQ_AudioTitleView.h
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseView.h"
@class XQ_SmallEditorModel;

typedef void(^GoBackPageBlock)(void);

@interface XQ_AudioTitleView : XQ_BaseView
/**模态返回block*/
@property(nonatomic, copy) GoBackPageBlock goBackBlock;

@property (nonatomic, retain) XQ_SmallEditorModel *model;

@end
