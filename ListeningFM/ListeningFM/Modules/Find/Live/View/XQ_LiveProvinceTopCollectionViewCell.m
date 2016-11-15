//
//  XQ_LiveProvinceTopCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/7.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveProvinceTopCollectionViewCell.h"
#import "XQ_LiveCategoriesModel.h"

@implementation XQ_LiveProvinceTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        [self addSubview:_label];
        

    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _label.frame = self.bounds;
    
    _label.clipsToBounds = YES;
    _label.layer.cornerRadius = 12;
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = 1;

    
}

- (void)setModel:(XQ_LiveCategoriesModel *)model{
    if (_model != model) {
        _model = model;
    }
    _label.text = model.name;
    
    if ([_label.text isEqualToString:@"北京"]) {
        _label.textColor = [UIColor redColor];
    }
    else {
        _label.textColor = [UIColor grayColor];
    }
    
}

-(void)setDidSelected:(BOOL)didSelected{
    if (didSelected == YES) {
        _label.textColor = [UIColor redColor];
    }
    else {
        _label.textColor = [UIColor grayColor];
    }
    
}


@end
