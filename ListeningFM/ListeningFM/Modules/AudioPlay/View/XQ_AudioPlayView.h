//
//  XQ_AudioPlayView.h
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseView.h"

@interface XQ_AudioPlayView : XQ_BaseView

// 播放按钮
@property (nonatomic, retain) UIButton *playButton;
// 上一曲
@property (nonatomic, retain) UIButton *previousButton;
// 下一曲
@property (nonatomic, retain) UIButton *nextButton;
// 是否在播放
@property (nonatomic, assign) BOOL play;

// 播放block
- (void)playImage:(NSString *)playImage pause:(NSString *)pauseImage play:(void (^)(UIButton *play))clickPlay pause:(void (^)(UIButton *pause))clickPause;
// 下一曲的block
- (void)nextImage:(NSString *)nextImage nextMusic:(void (^)(UIButton *next))clickNext;
// 上一曲的block
- (void)previousImage:(NSString *)previousImage previousMusic:(void (^)(UIButton *previous))clickPrevious;

@end
