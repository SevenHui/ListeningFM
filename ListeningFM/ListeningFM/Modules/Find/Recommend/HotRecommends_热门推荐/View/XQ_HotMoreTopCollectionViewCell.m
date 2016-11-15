//
//  XQ_HotMoreTopCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_HotMoreTopCollectionViewCell.h"

@implementation XQ_HotMoreTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        [self addSubview:_label];

    }
    return self;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _label.frame = self.bounds;
    
    _label.clipsToBounds = YES;
    _label.layer.cornerRadius = 12;
    _label.textColor = [UIColor grayColor];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = 1;
    
}

- (void)setModel:(XQ_HotRecModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    _label.text  = model.keywordName;
    
}

-(void)setDidSelected:(BOOL)didSelected{
    if (didSelected == YES) {
        self.label.textColor = [UIColor redColor];
    }
    else
    {
        self.label.textColor = [UIColor grayColor];
    }
    
}


@end
