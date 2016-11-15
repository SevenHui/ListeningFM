//
//  XQ_NavigationController.m
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_NavigationController.h"
#import <AVFoundation/AVFoundation.h>
#import "XQ_TabBarPlayButtonView.h"
#import "XQ_AudioPlayVC.h"

@interface XQ_NavigationController ()
<XQ_TabBarPlayButtonViewDelegate>

/**自定义播放按钮视图*/
@property (nonatomic, retain) XQ_TabBarPlayButtonView *playView;
/**图片*/
@property (nonatomic, retain) NSString *imageName;
/**播放器*/
@property (nonatomic, retain) AVPlayer *player;
/**地址*/
@property (nonatomic, retain) NSURL *audioURL;

@end

@implementation XQ_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 防止其他的ViewController的导航被遮挡
    self.navigationBarHidden = YES;
    
    // 开启一个通知接受,播放URL及图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingWithInfoDictionary:) name:@"BeginPlay" object:nil];
    
    self.playView = [[XQ_TabBarPlayButtonView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    _playView.delegate = self;
    [self.view addSubview:_playView];
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
    
}
// 隐藏图片
- (void)hidePlayView:(NSNotification *)notification {
    _playView.hidden = YES;
}

// 显示图片
- (void)showPlayView:(NSNotification *)notification {
    _playView.hidden = NO;
}
// 通过播放地址和播放图片
- (void)playingWithInfoDictionary:(NSNotification *)notification {
    // 设置背景图
    NSURL *coverURL = notification.userInfo[@"coverURL"];
    self.audioURL = notification.userInfo[@"musicURL"];
    [_playView.contentImageView sd_setImageWithURL:coverURL placeholderImage:nil options:SDWebImageRetryFailed];
    
    // 支持后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    // 开始播放
    _player = [AVPlayer playerWithURL:self.audioURL];
    [_player play];
    
    // 已改到背景变化时再变化
    _playView.playButton.selected = YES;
    
}

#pragma mark - PlayView的代理方法
- (void)playButtonDidClick:(BOOL)selected {
    // 按钮被点击方法, 判断按钮的selected状态
    if (selected) {
        // 继续播放
        [_player play];
    }
    else {
        // 暂停播放, 以后会取消, 此处应该是跳转最后一个播放器控制器
        [_player pause];
    }
    if (_audioURL == nil) {
        XQ_AudioPlayVC *audioPlayVC = [XQ_AudioPlayVC shareDetailViewController];
        [self presentViewController:audioPlayVC animated:YES completion:^{
            
        }];
    }
}



@end
