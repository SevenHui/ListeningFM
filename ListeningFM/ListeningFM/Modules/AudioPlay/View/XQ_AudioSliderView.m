//
//  XQ_AudioSliderView.m
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AudioSliderView.h"

@interface XQ_AudioSliderView ()

/**时间*/
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, copy) void (^changeSlider)(CGFloat value);
@property (nonatomic, copy) void (^changeSliderValue)(UISlider *slider);

@end

@implementation XQ_AudioSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 当前进度
        self.musicCurrentProgress = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH * 0.15, HEIGHT)];
        _musicCurrentProgress.text = @"00:00";
        _musicCurrentProgress.textAlignment = NSTextAlignmentCenter;
        _musicCurrentProgress.textColor = [UIColor whiteColor];
        _musicCurrentProgress.font = [UIFont systemFontOfSize:13];
        [self addSubview:_musicCurrentProgress];
        // 进度条
        self.playerSlider = [[UISlider alloc] initWithFrame:CGRectMake(_musicCurrentProgress.frame.size.width, 0, WIDTH - _musicCurrentProgress.frame.size.width * 2, HEIGHT)];
        [self addSubview:_playerSlider];
        [_playerSlider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        // 全部进度
        self.musicOverallProgress = [[UILabel alloc] initWithFrame:CGRectMake(_musicCurrentProgress.frame.size.width + _playerSlider.frame.size.width, 0, _musicCurrentProgress.frame.size.width, HEIGHT)];
        _musicOverallProgress.text = @"--:--";
        _musicOverallProgress.textColor = [UIColor whiteColor];
        _musicOverallProgress.textAlignment = NSTextAlignmentCenter;
        _musicOverallProgress.font = [UIFont systemFontOfSize:13];
        [self addSubview:_musicOverallProgress];

    }
    return self;
    
}
// 当前时间
- (void)addPlayerTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changeTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}
// 所剩时间
- (void)removePlayerTimer {
    [self.timer invalidate];
    self.timer = nil;
}
// 改变时间
- (void)changeTimer {
    self.changeSliderValue(self.playerSlider);
}
// 根据播放进度修改滑块的位置
- (void)playerSliderValue:(void (^)(UISlider *slider))changeSlider {
    self.changeSliderValue = changeSlider;
    
}
// 当前进度条的值
- (void)currentValue:(CGFloat)currentValue {
    _playerSlider.value = currentValue;
    _musicCurrentProgress.text = [self changeTimer:currentValue];
    
}
- (void)changeValue:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.musicCurrentProgress.text = [self changeTimer:slider.value];
    self.changeSlider(slider.value);
}
// 播放状态清空
- (void)playStatusClear {
    // 设置Slider的Value值为0
    [_playerSlider setValue:0.0];
    // 设置播放器的时间为0
    [_musicCurrentProgress setText:@"00:00"];
    // 移除定时器
    [self removePlayerTimer];
}
// 滑动滑块获得滑块的Value修改音频进度的Block
- (void)changeSliderValue:(void (^)(CGFloat value))changeValue {
     self.changeSlider = changeValue;
}
// 进度条图片
- (void)sliderThumb:(NSString *)thumbImageName
  maximumTrackImage:(NSString *)maximumTrackImageName
  minimumTrackImage:(NSString *)minimumTrackImageName {
    [_playerSlider setThumbImage:[UIImage imageNamed:thumbImageName] forState:UIControlStateNormal];
    [_playerSlider setMaximumTrackImage:[UIImage imageNamed:maximumTrackImageName] forState:UIControlStateNormal];
    [_playerSlider setMinimumTrackImage:[UIImage imageNamed:minimumTrackImageName] forState:UIControlStateNormal];
    
}
// 播放总时长
- (void)musicOverallValue:(CGFloat)overallValue {
    _playerSlider.maximumValue = overallValue;
    _musicOverallProgress.text = [self changeTimer:overallValue];
}
#pragma mark 将播放时长转为字符串
- (NSString *)changeTimer:(CGFloat)time {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (time >= 3600) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}



@end
