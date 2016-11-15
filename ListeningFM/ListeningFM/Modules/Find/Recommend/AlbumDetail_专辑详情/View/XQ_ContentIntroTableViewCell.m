//
//  XQ_ContentIntroTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_ContentIntroTableViewCell.h"

@implementation XQ_ContentIntroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"内容简介";
        [self addSubview:_contentLabel];
        
        self.introLabel = [[UILabel alloc] init];
        [self addSubview:_introLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _contentLabel.frame = CGRectMake(WIDTH * 0.02, HEIGHT * 0.05, WIDTH * 0.3, HEIGHT * 0.2);
    
    _introLabel.frame = CGRectMake(0, _contentLabel.frame.origin.y * 2 + _contentLabel.frame.size.height, WIDTH, HEIGHT * 0.65);
    _introLabel.font = [UIFont systemFontOfSize:15];
    _introLabel.numberOfLines = 0;
    
}

@end
