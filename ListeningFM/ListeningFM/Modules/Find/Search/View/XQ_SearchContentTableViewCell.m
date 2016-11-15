//
//  XQ_SearchContentTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_SearchContentTableViewCell.h"
#import "XQ_SmallEditorModel.h"

@implementation XQ_SearchContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftImageView];
        
        self.titleLbel = [[UILabel alloc] init];
        _titleLbel.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1];
        _titleLbel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLbel];
        
        self.categoryLabel = [[UILabel alloc] init];
        _categoryLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1];
        _categoryLabel.font = [UIFont systemFontOfSize:11];
        _categoryLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_categoryLabel];
        
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _leftImageView.frame = CGRectMake(WIDTH * 0.04, HEIGHT * 0.12, WIDTH * 0.16, HEIGHT * 0.76);
    
    _titleLbel.frame = CGRectMake(_leftImageView.frame.origin.x * 2 + _leftImageView.frame.size.width, _leftImageView.frame.size.height * 0.35, _leftImageView.frame.size.width * 5, _leftImageView.frame.size.height * 0.3);

    _categoryLabel.frame = CGRectMake(WIDTH * 0.75, _titleLbel.frame.origin.y, WIDTH * 0.2, _titleLbel.frame.size.height);
        
}

- (void)setModel:(XQ_SmallEditorModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"me"]];
    _titleLbel.text = model.keyword;
    _categoryLabel.text = model.category;
    
    // 搜索关键字高亮
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:_titleLbel.text];
    NSStringCompareOptions mask = NSCaseInsensitiveSearch | NSNumericSearch;
    NSRange range = [_titleLbel.text rangeOfString:_searchText options:mask];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [_titleLbel setAttributedText:attri];

    
}



@end
