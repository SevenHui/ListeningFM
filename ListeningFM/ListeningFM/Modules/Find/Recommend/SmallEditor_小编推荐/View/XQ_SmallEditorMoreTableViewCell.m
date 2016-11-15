//
//  XQ_SmallEditorMoreTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SmallEditorMoreTableViewCell.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_SmallEditorMoreTableViewCell ()

@property (nonatomic, retain) UIImageView *imageViewPhoto;
@property (nonatomic, retain) UILabel *labelTitle;
@property (nonatomic, retain) UILabel *labelSubtitle;
@property (nonatomic, retain) UIImageView *imageViewCount;
@property (nonatomic, retain) UILabel *labelCount;
@property (nonatomic, retain) UIImageView *imageViewNum;
@property (nonatomic, retain) UILabel *labelNum;

@end

@implementation XQ_SmallEditorMoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.font = [UIFont systemFontOfSize:18];
        [self addSubview:_labelTitle];
        
        self.labelSubtitle = [[UILabel alloc] init];
        _labelSubtitle.numberOfLines = 0;
        _labelSubtitle.font = [UIFont systemFontOfSize:15.5];
        _labelSubtitle.textColor = [UIColor grayColor];
        [self addSubview:_labelSubtitle];
        
        self.imageViewCount = [[UIImageView alloc] init];
        _imageViewCount.image = [UIImage imageNamed:@"find_albumcell_play"];
        [self addSubview:_imageViewCount];
        
        self.labelCount = [[UILabel alloc] init];
        _labelCount.font = [UIFont systemFontOfSize:15];
        _labelCount.textColor = [UIColor grayColor];
        [self addSubview:_labelCount];
        
        self.imageViewNum = [[UIImageView alloc] init];
        _imageViewNum.image = [UIImage imageNamed:@"find_hotUser_sounds"];
        [self addSubview:_imageViewNum];
        
        self.labelNum = [[UILabel alloc] init];
        _labelNum.font = [UIFont systemFontOfSize:15];
        _labelNum.textColor = [UIColor grayColor];
        [self addSubview:_labelNum];
        
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.15, WIDTH * 0.18, HEIGHT * 0.7);
    
    _labelTitle.frame = CGRectMake(_imageViewPhoto.frame.origin.x * 2 + _imageViewPhoto.frame.size.width , _imageViewPhoto.frame.origin.y * 1.2, _imageViewPhoto.frame.size.width * 3.8, _imageViewPhoto.frame.size.height * 0.45);
    
    _labelSubtitle.frame = CGRectMake(_labelTitle.frame.origin.x, _labelTitle.frame.size.height * 0.7 + _labelTitle.frame.origin.y , _labelTitle.frame.size.width, _imageViewPhoto.frame.size.height - _labelTitle.frame.size.height);
    
    _imageViewCount.frame =
    CGRectMake(_labelSubtitle.frame.origin.x,
               _labelSubtitle.frame.origin.y + _labelSubtitle.frame.size.height,
               WIDTH * 0.02, HEIGHT * 0.1);
    
    _labelCount.frame = CGRectMake(_imageViewCount.frame.origin.x + _imageViewCount.frame.size.width * 1.5, _imageViewCount.frame.origin.y, _imageViewCount.frame.size.width * 9, _imageViewCount.frame.size.height * 1.2);
    
    _imageViewNum.frame =
    CGRectMake(_labelCount.frame.origin.x + _labelCount.frame.size.width + _imageViewCount.frame.size.width,
               _labelCount.frame.origin.y,
               WIDTH * 0.02, HEIGHT * 0.1);
    
    _labelNum.frame = CGRectMake(_imageViewNum.frame.origin.x + _imageViewNum.frame.size.width * 1.5, _imageViewNum.frame.origin.y, _imageViewNum.frame.size.width * 7, _imageViewNum.frame.size.height * 1.2);
    
    
}

-(void)setModel:(XQ_SmallEditorModel *)model {
    if (_model != model) {
        _model = model;
    }

    
    [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"me"]];
    
    _labelTitle.text = model.title;
    
    if (model.intro != nil) {
        _labelSubtitle.text = model.intro;
    } else {
        _labelSubtitle.hidden = YES;
    }
    
    if ([model.playsCounts integerValue] != 0) {
        if ([model.playsCounts integerValue] < 10000) {
            _labelCount.text = [NSString stringWithFormat:@"%ld",[model.playsCounts integerValue]];
        } else {
            _labelCount.text = [NSString stringWithFormat:@"%.f万",[model.playsCounts floatValue] / 10000];
        }
    } else {
        _labelCount.hidden = YES;
        _imageViewCount.hidden = YES;
    }
    
    if (model.tracks != 0) {
        _labelNum.text = [NSString stringWithFormat:@"%@集", model.tracks];
    } else {
        _labelNum.hidden = YES;
        _imageViewNum.hidden = YES;
    }
    
    
}





@end
