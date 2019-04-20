//
//  FilterCollectionCell.h
//  filter Demo
//
//  Created by wangcl on 2019/4/20.
//  Copyright © 2019 wangcl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FilterModel;
@interface FilterCollectionCell : UICollectionViewCell

/**  */
@property (nonatomic,strong) FilterModel *model;


@end

NS_ASSUME_NONNULL_END
