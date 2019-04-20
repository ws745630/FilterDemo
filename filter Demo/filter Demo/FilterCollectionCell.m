//
//  FilterCollectionCell.m
//  filter Demo
//
//  Created by wangcl on 2019/4/20.
//  Copyright © 2019 wangcl. All rights reserved.
//

#import "FilterCollectionCell.h"
#import "FilterModel.h"

@interface FilterCollectionCell()

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *boderLine;

@end

@implementation FilterCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)setModel:(FilterModel *)model{
    _model = model;
    self.coverView.image = model.image;
    self.titleLabel.text = model.name;
    if (model.isSelected) {
        self.boderLine.hidden = NO;
    }else{
        self.boderLine.hidden = YES;
    }
}

- (void)createUI{
    self.backgroundColor = [UIColor redColor];
    self.coverView = [[UIImageView alloc] init];
    self.coverView.backgroundColor = BackGroundColor;
    [self.contentView addSubview:self.coverView];
    self.coverView.frame = CGRectMake(0, 0, 80, 80);
    
    self.boderLine = [[UIView alloc] init];
    self.boderLine.layer.borderColor = MainBlueColor.CGColor;
    self.boderLine.layer.borderWidth = 2 * SCALE_WIDTH;
    self.boderLine.backgroundColor = [UIColor clearColor];
    self.boderLine.hidden = YES;
    [self.contentView addSubview:self.boderLine];
    self.boderLine.frame = CGRectMake(0, 0, 82, 82);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 80,30)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
   
}

@end
