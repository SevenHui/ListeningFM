//
//  XQ_RankingTableViewCell.m
//  ListeningFM
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_RankingTableViewCell.h"
#import "XQ_RankingModel.h"

@interface XQ_RankingTableViewCell ()

/**封面*/
@property(nonatomic, retain) UIImageView *imageViewPhoto;
/**标题*/
@property(nonatomic, retain) UILabel *labelTitle;
/**副标题1*/
@property(nonatomic, retain) UILabel *labelDetailUp;
/**副标题2*/
@property (nonatomic, retain) UILabel *labelDetailDown;
/**角标*/
@property(nonatomic, retain) UIImageView *imageViewAngle;

@end

@implementation XQ_RankingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageViewPhoto = [[UIImageView alloc] init];
        [self addSubview:_imageViewPhoto];
        
        self.labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont systemFontOfSize:20];
        [self addSubview:_labelTitle];
        
        self.labelDetailUp = [[UILabel alloc] init];
        _labelDetailUp.textColor = [UIColor grayColor];
        [self addSubview:_labelDetailUp];
        
        self.labelDetailDown = [[UILabel alloc] init];
        _labelDetailDown.textColor = [UIColor grayColor];
        [self addSubview:_labelDetailDown];
        
        self.imageViewAngle = [[UIImageView alloc] init];
        _imageViewAngle.image = [UIImage imageNamed:@"messageCenter_cell_arrow"];
        [self addSubview:_imageViewAngle];
        

        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageViewPhoto.frame = CGRectMake(WIDTH * 0.05, HEIGHT * 0.15, WIDTH * 0.17, HEIGHT * 0.7);
    
    _labelTitle.frame = CGRectMake(_imageViewPhoto.frame.origin.x * 2 + _imageViewPhoto.frame.size.width, _imageViewPhoto.frame.origin.y * 0.8, _imageViewPhoto.frame.size.width * 3.7, _imageViewPhoto.frame.size.height * 0.4);
    
    _labelDetailUp.frame = CGRectMake(_labelTitle.frame.origin.x, _labelTitle.frame.origin.y * 1.4 + _labelTitle.frame.size.height, _labelTitle.frame.size.width, _imageViewPhoto.frame.size.height * 0.3);
    
    _labelDetailDown.frame = CGRectMake(_labelDetailUp.frame.origin.x, _labelDetailUp.frame.origin.y + _labelDetailUp.frame.size.height, _labelDetailUp.frame.size.width, _labelDetailUp.frame.size.height);

    _imageViewAngle.frame = CGRectMake(WIDTH * 0.92, HEIGHT * 0.4, WIDTH * 0.04, HEIGHT * 0.18);
    
    
}
- (void)setRankingModel:(XQ_RankingModel *)rankingModel {
    if (_rankingModel != rankingModel) {
        _rankingModel = rankingModel;
    }
    
    [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:rankingModel.coverPath] placeholderImage:[UIImage imageNamed:@"me"]];
    _labelTitle.text = rankingModel.title;
    _labelDetailUp.text = [NSString stringWithFormat:@"1 %@", [rankingModel.firstKResults[0] objectForKey:@"title"]];
    _labelDetailDown.text = [NSString stringWithFormat:@"2 %@", [rankingModel.firstKResults[1] objectForKey:@"title"]];
    
}



@end
