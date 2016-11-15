//
//  XQ_TwoProgramDetailTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_TwoProgramDetailTableViewCell.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_TwoProgramDetailTableViewCell ()

@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UIImageView *coverSmallImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *personImageView;
@property (nonatomic, retain) UILabel *nicknameLabel;

@end

@implementation XQ_TwoProgramDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.textAlignment = 1;
        _numberLabel.textColor = COLOR;
        [self addSubview:_numberLabel];
        
        self.coverSmallImageView = [[UIImageView alloc] init];
        [self addSubview:_coverSmallImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        
        self.personImageView = [[UIImageView alloc] init];
        _personImageView.image = [UIImage imageNamed:@"find_hotUser_fans"];
        [self addSubview:_personImageView];
        
        self.nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:14];
        _nicknameLabel.alpha = 0.5;
        [self addSubview:_nicknameLabel];
        
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    _numberLabel.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.4, WIDTH * 0.04, HEIGHT * 0.2);
    
    _coverSmallImageView.frame = CGRectMake(_numberLabel.frame.origin.x * 2+ _numberLabel.frame.size.width, HEIGHT * 0.2, HEIGHT * 0.6, HEIGHT * 0.6);
    _coverSmallImageView.layer.masksToBounds = YES;
    _coverSmallImageView.layer.cornerRadius = HEIGHT * 0.6 / 2;
    
    _titleLabel.frame = CGRectMake(_coverSmallImageView.frame.origin.x * 1.5 + _coverSmallImageView.frame.size.width, _coverSmallImageView.frame.origin.y, _coverSmallImageView.frame.size.width * 4, _coverSmallImageView.frame.size.height * 0.8);
    
    _personImageView.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y * 1.5 + _titleLabel.frame.size.height, WIDTH * 0.03, HEIGHT * 0.13);
    
    _nicknameLabel.frame = CGRectMake(_personImageView.frame.origin.x + _personImageView.frame.size.width * 1.5, _personImageView.frame.origin.y * 0.98, _personImageView.frame.size.width * 20, _personImageView.frame.size.height * 1.2);
    

}

- (void)setModel:(XQ_SmallEditorModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    [_coverSmallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"me"]];
    _titleLabel.text = model.title;
    _nicknameLabel.text = model.nickname;
    
}

- (void)setLabelInter:(NSInteger)labelInter{
    if (_labelInter != labelInter) {
        _labelInter = labelInter;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%ld",_labelInter];
    
}


@end
