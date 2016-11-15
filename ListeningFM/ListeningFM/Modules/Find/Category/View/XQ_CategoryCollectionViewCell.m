//
//  XQ_CategoryCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/24.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_CategoryCollectionViewCell.h"
#import "XQ_HotRecModel.h"

@interface XQ_CategoryCollectionViewCell ()

/**封面图片*/
@property (nonatomic, retain) UIImageView *imageViewPhoto;
/**标题*/
@property (nonatomic, retain) UILabel *labelTitle;

@end

@implementation XQ_CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelTitle = [[UILabel alloc] init];
        [self addSubview:_labelTitle];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.1, HEIGHT * 0.25, WIDTH * 0.12, HEIGHT * 0.5);
    
    _labelTitle.frame = CGRectMake(_imageViewPhoto.frame.origin.x * 2 + _imageViewPhoto.frame.size.width, _imageViewPhoto.frame.origin.y, _imageViewPhoto.frame.size.width * 4, _imageViewPhoto.frame.size.height);
    
}


- (void)setModel:(XQ_HotRecModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:model.coverPath] placeholderImage:[UIImage imageNamed:@"me"]];
    _labelTitle.text = model.title;
    
}




@end
