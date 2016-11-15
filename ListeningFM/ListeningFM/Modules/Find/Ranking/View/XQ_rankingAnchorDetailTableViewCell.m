//
//  XQ_rankingAnchorDetailTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_rankingAnchorDetailTableViewCell.h"
#import "XQ_RankingModel.h"

@interface XQ_rankingAnchorDetailTableViewCell ()

@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UIImageView *middleLogoImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *personDescribeLabel;
@property (nonatomic, retain) UIImageView *personImageView;
@property (nonatomic, retain) UILabel *followersCountsLabel;
@property (nonatomic, retain) UIImageView *turnImageView;

@end

@implementation XQ_rankingAnchorDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.numberLabel = [[UILabel alloc] init];
        [self addSubview:_numberLabel];
        
        self.middleLogoImageView = [[UIImageView alloc] init];
        [self addSubview:_middleLogoImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        [self addSubview:_nicknameLabel];
        
        self.personImageView = [[UIImageView alloc] init];
        _personImageView.image = [UIImage imageNamed:@"find_hotUser_fans"];
        [self addSubview:_personImageView];
        
        self.personDescribeLabel = [[UILabel alloc] init];
        _personDescribeLabel.font = [UIFont systemFontOfSize:14];
        _personDescribeLabel.alpha = 0.5;
        [self addSubview:_personDescribeLabel];
        
        self.followersCountsLabel = [[UILabel alloc] init];
        _followersCountsLabel.font = [UIFont systemFontOfSize:14];
        _followersCountsLabel.alpha = 0.5;
        [self addSubview:_followersCountsLabel];
        
        self.turnImageView = [[UIImageView alloc] init];
        _turnImageView.image = [UIImage imageNamed:@"messageCenter_cell_arrow"];
        [self addSubview:_turnImageView];
        
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _numberLabel.text = [NSString stringWithFormat:@"%ld",_number];
    _numberLabel.textColor = COLOR;
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.4, WIDTH * 0.04, HEIGHT * 0.2);

    _middleLogoImageView.frame = CGRectMake(_numberLabel.frame.origin.x * 2 + _numberLabel.frame.size.width, HEIGHT * 0.1, WIDTH * 0.2, HEIGHT * 0.75);
    
    _nicknameLabel.frame = CGRectMake(_middleLogoImageView.frame.origin.x * 1.5 + _middleLogoImageView.frame.size.width, _middleLogoImageView.frame.origin.y, _middleLogoImageView.frame.size.width * 2, _middleLogoImageView.frame.size.height * 0.35);
    
    _personDescribeLabel.frame = CGRectMake(_nicknameLabel.frame.origin.x, _nicknameLabel.frame.origin.y * 1.5 + _nicknameLabel.frame.size.height, _nicknameLabel.frame.size.width * 1.4, _nicknameLabel.frame.size.height * 0.9);
    
    _personImageView.frame = CGRectMake(_personDescribeLabel.frame.origin.x, _personDescribeLabel.frame.origin.y * 1.2 + _personDescribeLabel.frame.size.height, WIDTH * 0.03, HEIGHT * 0.12);
    
    _followersCountsLabel.frame = CGRectMake(_personImageView.frame.origin.x + _personImageView.frame.size.width * 1.5, _personImageView.frame.origin.y, _nicknameLabel.frame.size.width * 0.5, _personImageView.frame.size.height);
    
    _turnImageView.frame = CGRectMake(WIDTH * 0.93, HEIGHT * 0.4, WIDTH * 0.04, HEIGHT * 0.2);
    
    
}

- (void)setModel:(XQ_RankingModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [_middleLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.middleLogo] placeholderImage:[UIImage imageNamed:@"me"]];
    _nicknameLabel.text = model.nickname;
    _personDescribeLabel.text = model.personDescribe;
    
    if ([model.followersCounts integerValue] < 10000) {
        _followersCountsLabel.text = [NSString stringWithFormat:@"%ld",[model.followersCounts integerValue]];
    } else {
        _followersCountsLabel.text = [NSString stringWithFormat:@"%.1f万",[model.followersCounts floatValue]/ 10000];
    }
    
    
    
}



@end
