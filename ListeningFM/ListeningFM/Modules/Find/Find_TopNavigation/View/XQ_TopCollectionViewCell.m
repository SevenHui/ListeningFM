//
//  XQ_TopCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_TopCollectionViewCell.h"
#import "XQ_TopModel.h"

@interface XQ_TopCollectionViewCell ()

/**导航标题*/
@property (nonatomic, retain) UILabel *topLabel;
/**导航线*/
@property (nonatomic, retain) UILabel *lineLabel;

@end

@implementation XQ_TopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.topLabel = [[UILabel alloc] init];
        _topLabel.contentMode = UIViewContentModeScaleAspectFit;
        _topLabel.textAlignment = 1;
        [self.contentView addSubview:_topLabel];
        
        self.lineLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_lineLabel];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _topLabel.frame = self.bounds;
    
    _lineLabel.frame = CGRectMake(_topLabel.frame.size.width * 0.2, _topLabel.bounds.size.height * 0.92, _topLabel.frame.size.width * 0.6, _topLabel.bounds.size.height * 0.06);
    
}
- (void)setTopModel:(XQ_TopModel *)topModel {
    if (_topModel != topModel) {
        _topModel = topModel;
    }
    
    _topLabel.text = topModel.title;
    
}
#pragma mark - 切换标题的判断
- (void)setDidSelected:(BOOL)didSelected {

    if (didSelected == YES) {
        _topLabel.textColor = [UIColor colorWithRed:0.92 green:0.33 blue:0.20 alpha:1.00];
        _topLabel.font = [UIFont systemFontOfSize:19];
        _lineLabel.backgroundColor = [UIColor colorWithRed:0.92 green:0.33 blue:0.20 alpha:1.00];
    } else {
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.font = [UIFont systemFontOfSize:17];
        _lineLabel.backgroundColor = [UIColor clearColor];
    }
}



@end
