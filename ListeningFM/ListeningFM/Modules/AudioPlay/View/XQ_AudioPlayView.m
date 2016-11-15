//
//  XQ_AudioPlayView.m
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AudioPlayView.h"

@interface XQ_AudioPlayView ()

@property (nonatomic, copy) void (^clickedPlay)(UIButton *play);
@property (nonatomic, copy) void (^clickedPause)(UIButton *pause);
@property (nonatomic, copy) void (^clickedNext)(UIButton *next);
@property (nonatomic, copy) void (^clickedPrevious)(UIButton *previous);

@property (nonatomic, copy) NSString *playImage;
@property (nonatomic, copy) NSString *pauseImage;
@property (nonatomic, copy) NSString *nextImage;
@property (nonatomic, copy) NSString *previousImage;

@end

@implementation XQ_AudioPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 播放按钮
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
        // 上一曲
        self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_previousButton];
        // 下一曲
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextButton];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _playButton.frame = CGRectMake(WIDTH * 0.4, HEIGHT * 0.18, WIDTH * 0.2, WIDTH * 0.2);
    _previousButton.frame = CGRectMake(WIDTH * 0.18, HEIGHT * 0.25, WIDTH * 0.15, WIDTH * 0.15);
    _nextButton.frame = CGRectMake(WIDTH * 0.66, HEIGHT * 0.25, WIDTH * 0.15, WIDTH * 0.15);

}
// 播放block
- (void)playImage:(NSString *)playImage pause:(NSString *)pauseImage play:(void (^)(UIButton *play))clickPlay pause:(void (^)(UIButton *pause))clickPause{
    self.playImage = playImage;
    self.pauseImage = pauseImage;
    [self.playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPlay = clickPlay;
    self.clickedPause = clickPause;
}
- (void)playAction:(UIButton *)button{
    [button setImage:[UIImage imageNamed:self.pauseImage] forState:UIControlStateNormal];
    [button removeTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPlay(button);
}
- (void)pauseAction:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:self.playImage] forState:UIControlStateNormal];
    [button removeTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPause(button);
}

- (void)nextAction:(UIButton *)button
{
    self.clickedNext(button);
}
// 下一曲的block
- (void)nextImage:(NSString *)nextImage nextMusic:(void (^)(UIButton *next))clickNext
{
    self.nextImage = nextImage;
    [self.nextButton setBackgroundImage:[UIImage imageNamed:nextImage] forState:UIControlStateNormal];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:nextImage] forState:UIControlStateHighlighted];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedNext = clickNext;
}
// 上一曲的block
- (void)previousImage:(NSString *)previousImage previousMusic:(void (^)(UIButton *previous))clickPrevious
{
    self.previousImage = previousImage;
    [self.previousButton setBackgroundImage:[UIImage imageNamed:previousImage] forState:UIControlStateNormal];
    [self.previousButton setBackgroundImage:[UIImage imageNamed:previousImage] forState:UIControlStateHighlighted];
    [self.previousButton addTarget:self action:@selector(previousAction:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedPrevious = clickPrevious;
}

- (void)previousAction:(UIButton *)button
{
    self.clickedPrevious(button);
}

- (void)setPlay:(BOOL)play{
    if (play) {
        [self playAction:_playButton];
        
    }
    else{
        [self pauseAction:_playButton];
        
        
    }
}


@end
