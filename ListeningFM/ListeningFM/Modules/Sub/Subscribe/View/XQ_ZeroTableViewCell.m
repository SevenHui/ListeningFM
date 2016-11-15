//
//  XQ_ZeroTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_ZeroTableViewCell.h"

@implementation XQ_ZeroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backimageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_backimageView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backimageView.frame = CGRectMake(WIDTH * 0.15, HEIGHT * 0.15, WIDTH * 0.7, HEIGHT * 0.4);
    
    _button.layer.cornerRadius = 5;
    _button.frame = CGRectMake(WIDTH * 0.38, HEIGHT * 0.58, WIDTH * 0.24, HEIGHT * 0.06);
    
}


@end
