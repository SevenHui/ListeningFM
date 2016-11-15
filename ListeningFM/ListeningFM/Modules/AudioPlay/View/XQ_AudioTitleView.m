//
//  XQ_AudioTitleView.m
//  ListeningFM
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AudioTitleView.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_AudioTitleView ()

/**返回按钮*/
@property (nonatomic, retain) UIButton *backButton;
/**标题*/
@property(nonatomic, retain) UILabel *titleLabel;

@end

@implementation XQ_AudioTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"icon_radio_show"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHSCREEN * 0.2, HEIGHTSCREEN * 0.04, WIDTHSCREEN * 0.55, HEIGHTSCREEN * 0.03)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backButton.frame = CGRectMake(WIDTHSCREEN * 0.04, HEIGHTSCREEN * 0.05, WIDTHSCREEN * 0.06, HEIGHTSCREEN * 0.03);
    
}
- (void)setModel:(XQ_SmallEditorModel *)model {
    if (_model != model) {
        _model = model;
    }
    _titleLabel.text = model.title;
    
}
- (void)backButtonAction:(UIButton *)backButton {
    self.goBackBlock();
}

@end
