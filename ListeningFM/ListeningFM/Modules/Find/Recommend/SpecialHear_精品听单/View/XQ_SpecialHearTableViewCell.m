//
//  XQ_SpecialHearTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SpecialHearTableViewCell.h"
#import "XQ_SmallEditorModel.h"

@interface XQ_SpecialHearTableViewCell ()

/**封面图片*/
@property (nonatomic, retain) UIImageView *imageViewPhoto;
/**标题*/
@property (nonatomic, retain) UILabel *labelTitle;
/**副标题*/
@property (nonatomic, retain) UILabel *labelSubtitle;
/**图标*/
@property (nonatomic, retain) UIImageView *imageViewSmallPhoto;
/**数量*/
@property (nonatomic, retain) UILabel *labelFootnote;
/**角标*/
@property (nonatomic, retain) UIImageView *imageViewAngle;

@end

@implementation XQ_SpecialHearTableViewCell

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
        _labelSubtitle.textColor = [UIColor grayColor];
        _labelSubtitle.font = [UIFont systemFontOfSize:15];
        [self addSubview:_labelSubtitle];
        
        self.imageViewSmallPhoto = [[UIImageView alloc] init];
        _imageViewSmallPhoto.image = [UIImage imageNamed:@"find_specialicon"];
        [self addSubview:_imageViewSmallPhoto];
        
        self.labelFootnote = [[UILabel alloc] init];
        _labelFootnote.font = [UIFont systemFontOfSize:14];
        _labelFootnote.textColor = [UIColor grayColor];
        [self addSubview:_labelFootnote];
        
        self.imageViewAngle = [[UIImageView alloc] init];
        _imageViewAngle.image = [UIImage imageNamed:@"messageCenter_cell_arrow"];
        [self addSubview:_imageViewAngle];
        
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.03, HEIGHT * 0.07, WIDTH * 0.18, HEIGHT * 0.7);
    
    _labelTitle.frame = CGRectMake(_imageViewPhoto.frame.origin.x * 2 + _imageViewPhoto.frame.size.width , 0, _imageViewPhoto.frame.size.width * 3.5, _imageViewPhoto.frame.size.height * 0.45);
    
    _labelSubtitle.frame = CGRectMake(_labelTitle.frame.origin.x, _labelTitle.frame.size.height * 0.8, _labelTitle.frame.size.width, _labelTitle.frame.size.height * 1.4);
    
    _imageViewSmallPhoto.frame = CGRectMake(_labelSubtitle.frame.origin.x, (_labelSubtitle.frame.origin.y + _labelSubtitle.frame.size.height) / 0.9, _labelSubtitle.frame.size.width * 0.05, _labelSubtitle.frame.size.width * 0.05);
    
    _labelFootnote.frame = CGRectMake(_imageViewSmallPhoto.frame.origin.x + _imageViewSmallPhoto.frame.size.width, _imageViewSmallPhoto.frame.origin.y, _labelSubtitle.frame.size.width * 0.3, _imageViewSmallPhoto.frame.size.width);
    
    _imageViewAngle.frame = CGRectMake(WIDTH * 0.92, HEIGHT * 0.4, WIDTH * 0.04, HEIGHT * 0.18);
    
}
- (void)setSpecialHearModel:(XQ_SmallEditorModel *)specialHearModel {
    if (_specialHearModel != specialHearModel) {
        _specialHearModel = specialHearModel;
    }
    
    [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:specialHearModel.coverPath] placeholderImage:[UIImage imageNamed:@"me"]];
    _labelTitle.text = specialHearModel.title;
    _labelSubtitle.text = specialHearModel.subtitle;
    _labelFootnote.text = specialHearModel.footnote;
    
}





@end
