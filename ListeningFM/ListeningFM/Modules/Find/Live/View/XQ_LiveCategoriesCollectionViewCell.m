//
//  XQ_LiveCategoriesCollectionViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_LiveCategoriesCollectionViewCell.h"
#import "XQ_LiveCategoriesModel.h"

@interface XQ_LiveCategoriesCollectionViewCell ()

/**电台名*/
@property (nonatomic, retain) UILabel *labelName;

@end

@implementation XQ_LiveCategoriesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.labelName = [[UILabel alloc] init];
        _labelName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelName];
                
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _labelName.frame = self.bounds;
    
}

- (void)setCateModel:(XQ_LiveCategoriesModel *)cateModel {
    if (_cateModel != cateModel) {
        _cateModel = cateModel;
    }
    
    _labelName.text = cateModel.name;
    
}

@end
