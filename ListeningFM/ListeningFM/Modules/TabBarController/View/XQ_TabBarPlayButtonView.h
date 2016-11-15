//
//  XQ_TabBarPlayButtonView.h
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseView.h"

@protocol XQ_TabBarPlayButtonViewDelegate <NSObject>
// 传入按钮的属性
- (void)playButtonDidClick:(BOOL)isSelected;

@end

@interface XQ_TabBarPlayButtonView : XQ_BaseView

/**背景图片*/
@property (nonatomic, retain) UIImageView *circleImageView;
/**播放图片*/
@property (nonatomic, retain) UIImageView *contentImageView;
/**播放按钮*/
@property (nonatomic, retain) UIButton *playButton;

@property (nonatomic, assign) id<XQ_TabBarPlayButtonViewDelegate>delegate;

@end
