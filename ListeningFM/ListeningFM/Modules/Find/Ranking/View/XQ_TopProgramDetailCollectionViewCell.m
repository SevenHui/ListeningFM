//
//  XQ_TopProgramDetailCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_TopProgramDetailCollectionViewCell.h"
#import "XQ_RankingModel.h"

@implementation XQ_TopProgramDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.topLabel = [[UILabel alloc] init];
        _topLabel.contentMode = UIViewContentModeScaleAspectFit;
        _topLabel.textAlignment = 1;
        [self addSubview:_topLabel];
        
        self.lineLabel = [[UILabel alloc] init];
        [self addSubview:_lineLabel];
        
        
    }
    return self;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _topLabel.frame = self.bounds;
    
    _lineLabel.frame = CGRectMake(_topLabel.frame.size.width * 0.2, _topLabel.bounds.size.height * 0.92, _topLabel.frame.size.width * 0.6, _topLabel.bounds.size.height * 0.06);
    
    
}

- (void)setModel:(XQ_RankingModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    _topLabel.text  = model.name;
    
}

- (void)setDidSelected:(BOOL)didSelected {
    if (didSelected == YES) {
        _topLabel.textColor = [UIColor redColor];
        _lineLabel.backgroundColor = [UIColor redColor];
    } else {
        _topLabel.textColor = [UIColor blackColor];
        _lineLabel.backgroundColor = [UIColor clearColor];
    }
    
}

@end
