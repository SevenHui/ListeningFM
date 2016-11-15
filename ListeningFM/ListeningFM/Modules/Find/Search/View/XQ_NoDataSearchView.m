//
//  XQ_NoDataSearchView.m
//  ListeningFM
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_NoDataSearchView.h"

@implementation XQ_NoDataSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.noDataSearchImageView = [[UIImageView alloc] init];
        _noDataSearchImageView.image = [UIImage imageNamed:@"noData_search"];
        [self addSubview:_noDataSearchImageView];
        

        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _noDataSearchImageView.frame = CGRectMake(WIDTH * 0.15, HEIGHT * 0.15, WIDTH * 0.7, HEIGHT * 0.4);
    
}

@end
