//
//  XQ_AnchorIntroduceTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_AnchorIntroduceTableViewCell.h"

@implementation XQ_AnchorIntroduceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        self.smallLogoImageView = [[UIImageView alloc] init];
        [self addSubview:_smallLogoImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self addSubview:_nicknameLabel];
        
        self.followersLabel = [[UILabel alloc] init];
        [self addSubview:_followersLabel];
        
        self.personalSignatureLabel = [[UILabel alloc] init];
        [self addSubview:_personalSignatureLabel];
        

    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(WIDTH * 0.02, HEIGHT * 0.04, WIDTH * 0.3, HEIGHT * 0.2);
    
    _smallLogoImageView.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y * 1.2 + _titleLabel.frame.size.height, _titleLabel.frame.size.height * 1.5, _titleLabel.frame.size.height * 1.5);
    _smallLogoImageView.layer.masksToBounds = YES;
    _smallLogoImageView.layer.cornerRadius = _titleLabel.frame.size.height * 1.5 / 2;
    
    _nicknameLabel.frame = CGRectMake(_smallLogoImageView.frame.origin.x * 3 + _smallLogoImageView.frame.size.width, _smallLogoImageView.frame.origin.y, _smallLogoImageView.frame.size.width * 3, _smallLogoImageView.frame.size.height * 0.4);
    
    _followersLabel.frame = CGRectMake(_nicknameLabel.frame.origin.x, _nicknameLabel.frame.origin.y + _nicknameLabel.frame.size.height * 1.3, _nicknameLabel.frame.size.width, _nicknameLabel.frame.size.height);
    _followersLabel.font = [UIFont systemFontOfSize:14];
    _followersLabel.alpha = 0.5;
    
    _personalSignatureLabel.frame = CGRectMake(0, _smallLogoImageView.frame.origin.y * 1.1 + _smallLogoImageView.frame.size.height, WIDTH, HEIGHT * 0.4);
    _personalSignatureLabel.font = [UIFont systemFontOfSize:14];
    _personalSignatureLabel.numberOfLines = 0;
    
}
- (void)setModel:(XQ_AnchorIntroduceModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    self.titleLabel.text = @"主播介绍";
    [self.smallLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.smallLogo] placeholderImage:[UIImage imageNamed:@"no_network"]];
    self.nicknameLabel.text = model.nickname;
    self.followersLabel.text = [NSString stringWithFormat:@"已被%.1f万人关注",[[model followers] floatValue] / 10000];
    self.personalSignatureLabel.text = model.personalSignature;
    
    
    
    
}

@end
