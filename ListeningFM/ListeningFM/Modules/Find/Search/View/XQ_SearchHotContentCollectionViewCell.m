//
//  XQ_SearchHotContentCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SearchHotContentCollectionViewCell.h"

@implementation XQ_SearchHotContentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:12];
        _label.layer.cornerRadius = 12.5;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.layer.masksToBounds = YES;
        _label.layer.borderColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1].CGColor;
        _label.layer.borderWidth = 1;
        [self.contentView addSubview:_label];
        
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _label.frame = self.bounds;

}


@end
