//
//  XQ_HeaderDetailView.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HeaderDetailView.h"

@interface XQ_HeaderDetailView ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *bigLabel;
@property (nonatomic, retain) UILabel *xiaobianLabel;
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;

@end

@implementation XQ_HeaderDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
    
}

- (void)layoutSubviews {
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTHSCREEN * 0.03, HEIGHTSCREEN * 0.03, WIDTHSCREEN * 0.12, WIDTHSCREEN * 0.12)];
    [self addSubview:_imageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x * 2 + _imageView.frame.size.width, _imageView.frame.origin.y, _imageView.frame.size.width * 6, _imageView.frame.size.height)];
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    
    self.bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x, _imageView.frame.origin.y * 1.5 + _imageView.frame.size.height, WIDTHSCREEN - _imageView.frame.origin.x * 2, HEIGHTSCREEN * 0.18)];
    _bigLabel.font = [UIFont systemFontOfSize:14];
    _bigLabel.alpha = 0.5;
    _bigLabel.numberOfLines = 0;
    [self addSubview:_bigLabel];
    
    self.xiaobianLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bigLabel.frame.size.width * 0.65, _bigLabel.frame.origin.y * 1.1 + _bigLabel.frame.size.height, _bigLabel.frame.size.width * 0.1, HEIGHTSCREEN * 0.03)];
    _xiaobianLabel.alpha = 0.5;
    _xiaobianLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_xiaobianLabel];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_xiaobianLabel.frame.origin.x + _xiaobianLabel.frame.size.width * 1.2, _xiaobianLabel.frame.origin.y, _xiaobianLabel.frame.size.width * 0.5, _xiaobianLabel.frame.size.width * 0.5)];
    _headImageView.layer.cornerRadius = _xiaobianLabel.frame.size.width * 0.5 / 2;
    [self addSubview:_headImageView];

    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width * 1.3, _headImageView.frame.origin.y, _headImageView.frame.size.width * 3, _headImageView.frame.size.height)];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.alpha = 0.5;
    [self addSubview:_nameLabel];
    
    
}
- (void)setDitionary:(NSDictionary *)ditionary{
    if (_ditionary != ditionary) {
        _ditionary = ditionary;
    }
    
    _imageView.image = [UIImage imageNamed:@"findsubject_cover"];
    _titleLabel.text = [_ditionary objectForKey:@"title"];
    _bigLabel.text = [_ditionary objectForKey:@"intro"];
    _xiaobianLabel.text = @"小编:";
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_ditionary objectForKey:@"smallLogo"]] placeholderImage:[UIImage imageNamed:@"user_head_comment"]];
    _nameLabel.text = [_ditionary objectForKey:@"nickname"];
    
}

@end
