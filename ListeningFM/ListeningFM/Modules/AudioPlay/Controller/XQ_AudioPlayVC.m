//
//  XQ_AudioPlayVC.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AudioPlayVC.h"
#import "AppDelegate.h"
#import "XQ_AudioTitleView.h"
#import "XQ_AudioPlayView.h"
#import "XQ_AudioSliderView.h"
#import "AudioPlayerManager.h"
#import "CALayer+PauseAimate.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_AudioPlayVC ()
// 音频播放代理
<AudioPlayerManagerDelegate>

/**背景图片*/
@property (nonatomic, retain) UIImageView *backgroundImageView;
/**播放图片*/
@property (nonatomic, retain) UIImageView *playImageView;
/**专辑标题视图*/
@property(nonatomic, retain) XQ_AudioTitleView *audioTitleView;
/**进度条视图*/
@property (nonatomic, retain) XQ_AudioSliderView *audioSliderView;
/**播放视图*/
@property (nonatomic, retain) XQ_AudioPlayView *audioPlayView;
/**音乐播放器*/
@property (nonatomic, retain) AudioPlayerManager *playerManager;

@end

@implementation XQ_AudioPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
    
    [self createView];
    
}

+ (XQ_AudioPlayVC *)shareDetailViewController {
    static XQ_AudioPlayVC *detail = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        detail = [[XQ_AudioPlayVC alloc] init];
    });
    return detail;
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.playerManager = [AudioPlayerManager shareAudioPlayerManager];
        self.playerManager.delegate = self;
    }
    return self;
}


- (void)createView {
    // 背景图片
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    [self.view addSubview:_backgroundImageView];
    // 毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.frame = _backgroundImageView.bounds;
    [_backgroundImageView addSubview:toolBar];
    // 专辑标题视图
    self.audioTitleView = [[XQ_AudioTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _audioTitleView.model = _model;
    __weak XQ_AudioPlayVC *audioPlayVC = self;
    _audioTitleView.goBackBlock = ^(void)
    {
        NSString *state = @"";
        if (self.playerManager.rate == 0) {
            state = @"playing";
        } else {
            state = @"pause";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"good" object:state];
        [audioPlayVC dismissViewControllerAnimated:YES completion:^{
        }];
    };
    [self.view addSubview:_audioTitleView];
    // 播放图片
    self.playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTHSCREEN * 0.13, _audioTitleView.frame.size.height * 1.8, WIDTHSCREEN * 0.74, WIDTHSCREEN * 0.74)];
    _playImageView.clipsToBounds = YES;
    _playImageView.layer.cornerRadius = WIDTHSCREEN * 0.74 / 2;
    _playImageView.layer.borderWidth = 7;
    _playImageView.layer.borderColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.0].CGColor;
    [_playImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    [self.view addSubview:_playImageView];
    // 进度条视图
    self.audioSliderView = [[XQ_AudioSliderView alloc] initWithFrame:CGRectMake(WIDTHSCREEN * 0.04, HEIGHTSCREEN * 0.75, WIDTHSCREEN * 0.92, HEIGHTSCREEN * 0.05)];
    // 进度条图片
    [_audioSliderView sliderThumb:@"player_slider_playback_thumb" maximumTrackImage:@"player_slider_playback_right" minimumTrackImage:@"player_slider_playback_left"];
    [_audioSliderView musicOverallValue:[_model.duration floatValue]];
    [self.view addSubview:_audioSliderView];
    // 播放控制视图
    self.audioPlayView = [[XQ_AudioPlayView alloc] initWithFrame:CGRectMake(WIDTHSCREEN * 0.04, HEIGHTSCREEN * 0.8, WIDTHSCREEN * 0.92, HEIGHTSCREEN * 0.15)];
    [self.view addSubview:_audioPlayView];
    // 播放控制视图的播放和暂停
    [_audioPlayView playImage:@"player_btn_play_normal" pause:@"player_btn_pause_normal" play:^(UIButton *play) {
        // 播放音频
        [audioPlayVC.playerManager play];
        [audioPlayVC.playImageView.layer resumeAnimate];
        // 添加进度监听定时器
        [audioPlayVC.audioSliderView addPlayerTimer];
        [_audioSliderView playerSlider];
        
    } pause:^(UIButton *pause) {
        // 暂停音频
        [audioPlayVC.playerManager pause];
        [audioPlayVC.playImageView.layer pauseAnimate];
        // 移除进度监听定时器
        [_audioSliderView removePlayerTimer];
    }];
    // 下一曲
    [_audioPlayView nextImage:@"player_btn_next_normal" nextMusic:^(UIButton *next) {
        _index++;
        
        if (_index >= _musicArr.count) {
            _index = _musicArr.count - 1;
            [self changeMusicAlert:@"已经为最后一曲"];
        } else {
            self.model = _musicArr[_index];
        }
    }];
    // 上一曲
    [_audioPlayView previousImage:@"player_btn_pre_normal" previousMusic:^(UIButton *previous) {
        _index--;
        if (_index < 0) {
            _index = 0;
            [self changeMusicAlert:@"当前为第一曲"];
        } else {
            self.model = _musicArr[_index];
        }
    }];
#pragma mark - 音频播放进行时修改进度条位置
    [_audioSliderView playerSliderValue:^(UISlider *slider) {
        float value = CMTimeGetSeconds(self.playerManager.currentItem.currentTime);
        slider.value = value;
        [audioPlayVC.audioSliderView currentValue:value];
    }];
    
#pragma mark - 拖动进度条修改音频位置
    [_audioSliderView changeSliderValue:^(CGFloat value) {
        [audioPlayVC.audioSliderView removePlayerTimer];
        [audioPlayVC.playerManager pause];
        [audioPlayVC.playerManager seekToTime:CMTimeMakeWithSeconds(value, audioPlayVC.playerManager.currentTime.timescale) completionHandler:^(BOOL finished) {
            if (finished) {
                [audioPlayVC.playerManager play];
                [audioPlayVC.audioSliderView addPlayerTimer];
            }
        }];
    }];
}
#pragma mark - 播放音乐
- (void)playSounds {
    _audioTitleView.model = self.model;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    [_playImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverSmall] placeholderImage:[UIImage imageNamed:@"me_bg2"] options:SDWebImageRetryFailed];
    // 播放
    _audioPlayView.play = YES;
    [self addIconViewAnimate];
    // 播放音频
    if (_model.playPathAacv224 == nil) {
        [self.playerManager playerPlayWithUrl:_model.playPath64];
    }
    else{
        [self.playerManager playerPlayWithUrl:_model.playPathAacv224];
    }
}
#pragma mark - 重新给歌曲信息赋值并停止上一曲,播放当前歌曲
- (void)setModel:(XQ_SmallEditorModel *)model {
    if (model != _model) {
        _model = model;
        if (_audioSliderView) {
            [_audioSliderView musicOverallValue:[_model.duration integerValue]];
        }
        [self playerStop];
        [self playSounds];
    }
}
#pragma mark - 播放器暂停播放:
- (void)playerStop {
    // 让播放器终止
    [self.playerManager stop];
    // 清除播放状态
    [_audioSliderView playStatusClear];
    // 设置播放的按钮为要播放状态
    _audioPlayView.play = NO;
}
#pragma mark - 播放器的协议停止方法
- (void)didFinshPlay {
    if (_musicArr) {
        [self playerStop];
        _index = _index + 1;
        if (_index >= _musicArr.count) {
            _index = 0;
        }
        _model = [_musicArr objectAtIndex:_index];
    }
}
#pragma mark - 播放到最后或最前提示
- (void)changeMusicAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 给图片层添加动画
- (void)addIconViewAnimate {
    // 创建动画
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 动画设置属性
    rotationAnim.fromValue = @(0);
    rotationAnim.toValue = @(M_PI * 2);
    rotationAnim.repeatCount = NSIntegerMax;
    rotationAnim.duration = 35;
    // 添加动画
    [_playImageView.layer addAnimation:rotationAnim forKey:nil];
}
#pragma mark - 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    // 给播放图片添加动画
    [self addIconViewAnimate];
    _audioPlayView.play = YES;
    // 隐藏导航
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}





@end
