//
//  XQ_LiveTopCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveTopCollectionViewCell.h"

@implementation XQ_LiveTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelName = [[UILabel alloc] init];
        _labelName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelName];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.15, HEIGHT * 0.2, WIDTH * 0.7, HEIGHT * 0.5);
    
    _labelName.frame = CGRectMake(_imageViewPhoto.frame.origin.x, _imageViewPhoto.frame.origin.y + _imageViewPhoto.frame.size.height, _imageViewPhoto.frame.size.width, _imageViewPhoto.frame.size.height * 0.5);
    
}

@end
