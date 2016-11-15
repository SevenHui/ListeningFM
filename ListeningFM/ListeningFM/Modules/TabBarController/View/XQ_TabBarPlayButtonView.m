//
//  XQ_TabBarPlayButtonView.m
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_TabBarPlayButtonView.h"

@interface XQ_TabBarPlayButtonView ()

// 设置一个私有的定时器
@property (nonatomic, retain) CADisplayLink *timer;

@end

@implementation XQ_TabBarPlayButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 布局
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        backgroundImageView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        [self addSubview:backgroundImageView];
        
        UIImageView *showImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_playshadow"]];
        showImageView.frame = CGRectMake(0, 0, 65, 65);
        [backgroundImageView addSubview:showImageView];
        // 旋转图
        self.circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_np_loop"]];
        _circleImageView.frame = CGRectMake(5, 5, 55, 55);
        _circleImageView.layer.cornerRadius = 55 / 2;
        [backgroundImageView addSubview:_circleImageView];
        
        // 设置用户交互
        backgroundImageView.userInteractionEnabled = YES;
        _circleImageView.userInteractionEnabled = YES;
        
        // 点击按钮前
        [self.playButton setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
        // 点击按钮
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClicked:) name:@"good" object:nil];

        
    }
    return self;
}

// 点击按钮监听事件
- (void)didClicked:(NSNotification *)not {
    if ([not.object isEqualToString:@"pause"]) {
        [self.timer setPaused:NO];
        [self.playButton setImage:[UIImage imageNamed:@"toolbar_pause_h"] forState:UIControlStateNormal];
    }
    else {
        [self.timer setPaused:YES];
        [self.playButton setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
    }
}
// 旋转图
- (void)rotation {
    self.circleImageView.layer.transform = CATransform3DRotate(self.circleImageView.layer.transform, AngleToRadian(72 / 60.0), 0, 0, 1);
}
#pragma mark - 播放按钮和播放图片CADisplayLink定时器懒加载
- (UIButton *)playButton {
    if (!_playButton) {
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 去掉长按高亮
        [_playButton setHighlighted:NO];
        _playButton.frame = CGRectMake(5, 5, 55, 55);
        _playButton.layer.cornerRadius = 55 / 2;
        [self addSubview:_playButton];
        // 点击按钮后的方法
        [_playButton addTarget:self action:@selector(didClickedPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
    
}
#pragma mark - 点击播放按钮
- (void)didClickedPlayButton:(UIButton *)sender {
    // 点击和不点击时图片交换
    if ([self.delegate respondsToSelector:@selector(playButtonDidClick:)]) {
        sender.selected = !sender.selected;
        self.timer.paused = !sender.selected;
        
        [self.delegate playButtonDidClick:sender.selected];
        
    }
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        // 声明一个内容视图, 并约束好位置
        _contentImageView = [[UIImageView alloc] init];
        // 绑定到圆视图
        [self.circleImageView addSubview:_contentImageView];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
        // KVO观察image变化,变化了就启动定时器
        [self.contentImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        
        // 作圆内容视图背景
        self.contentImageView.layer.cornerRadius = 22.5;
        self.contentImageView.clipsToBounds = YES;
    }
    return _contentImageView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        // 启动定时器
        self.playButton.selected = YES;
        self.timer.paused = NO;
    }
}

- (CADisplayLink *)timer {
    if (!_timer) {
        // 创建定时器, 一秒钟调用rotation方法60次
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotation)];
        // 手动将定时器加入到事件循环中
        // NSRunLoopCommonModes会使得RunLoop会随着界面切换扔继续使用, 不然如果使用Default的话UI交互没问题, 但滑动TableView就会出现不转问题, 因为RunLoop模式改变会影响定时器调度
        [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _timer;
    
}


@end
