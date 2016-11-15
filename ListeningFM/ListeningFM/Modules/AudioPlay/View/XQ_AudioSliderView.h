//
//  XQ_AudioSliderView.h
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_BaseView.h"

@protocol XQ_AudioSliderViewDelegate <NSObject>
@optional
- (void)sliderScroll:(CGFloat)value;

@end

@interface XQ_AudioSliderView : XQ_BaseView
// 签代理
@property (nonatomic, assign) id<XQ_AudioSliderViewDelegate>delegate;

/**播放进度条*/
@property (nonatomic, retain) UISlider *playerSlider;
/**音频播放当前进度*/
@property (nonatomic, retain) UILabel *musicCurrentProgress;
/**音频播放全部进度*/
@property (nonatomic, retain) UILabel *musicOverallProgress;
// 进度条图片
- (void)sliderThumb:(NSString *)thumbImageName
  maximumTrackImage:(NSString *)maximumTrackImageName
  minimumTrackImage:(NSString *)minimumTrackImageName;

// 播放总时长
- (void)musicOverallValue:(CGFloat)overallValue;

// 当前进度条的值
- (void)currentValue:(CGFloat)currentValue;

// 滑动滑块获得滑块的Value修改音频进度的Block
- (void)changeSliderValue:(void (^)(CGFloat value))changeValue;

// 根据播放进度修改滑块的位置
- (void)playerSliderValue:(void (^)(UISlider *slider))changeSlider;

// 播放状态清空
- (void)playStatusClear;
// 当前时间
- (void)addPlayerTimer;
// 剩余时间
- (void)removePlayerTimer;

@end
