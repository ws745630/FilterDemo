//
//  CoverBottomView.m
//  wxer_manager
//
//  Created by levin on 2017/7/11.
//  Copyright © 2017年 congzhikeji. All rights reserved.
//

#import "CoverBottomView.h"
#import "FilterModel.h"
#import "ImageRender.h"
#import "FilterCollectionCell.h"

static NSString *FILTERCELLID = @"CoverFilterCellID";

@interface CoverBottomView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *templateView; //承载所有模板view
@property (nonatomic, strong) NSMutableArray *filterArr;

@end

@implementation CoverBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = ColorRGBA(9, 9, 8, 1);
        [self createUI];
        [self setData];
    }
    return self;
}
-(void)setData{
    NSArray *filterNames = @[@"原片",@"LOMO",@"风景",@"梦幻",@"清凉",@"阳光",@"温暖",@"人物",@"黄昏",@"静物",@"褐色怀旧",@"灰度",@"1977",@"黑白"];
    self.filterArr = [NSMutableArray array];
    for (int i = 0; i < filterNames.count;i ++) {
        FilterModel *model = [[FilterModel alloc] init];
        if (i == 0) {
            model.isSelected = YES;
        }
        model.name = filterNames[i];
        model.image = [ImageRender renderFilter:model.name image:ImageName(@"bgImage")];
        [self.filterArr addObject:model];
    }
    
}
/**  */
-(void)createUI{
    [self addSubview:self.collectionView];
}
#pragma mark - collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filterArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:FILTERCELLID forIndexPath:indexPath];
    cell.model = self.filterArr[indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(coverBottom:didSelectModel:)]){
        FilterModel *model = self.filterArr[indexPath.row];
        [self.delegate coverBottom:self didSelectModel:model];
    }
    for (FilterModel *model in self.filterArr) {
        model.isSelected = NO;
    }
    FilterModel *currentModel = self.filterArr[indexPath.row];
    currentModel.isSelected = YES;
    [self.collectionView reloadData];
}
#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80,80);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGRect rect = CGRectMake(0, 0, self.easy_width, self.easy_height);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[FilterCollectionCell class] forCellWithReuseIdentifier:FILTERCELLID];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizesSubviews = YES;
    }
    return _collectionView;
}
@end
