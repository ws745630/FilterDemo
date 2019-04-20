//
//  ViewController.m
//  filter Demo
//
//  Created by wangcl on 2019/4/20.
//  Copyright © 2019 wangcl. All rights reserved.
//

#import "ViewController.h"
#import "CoverBottomView.h"
#import "FilterModel.h"
@interface ViewController ()<CoverBottomDelegate>

/**  */
@property (nonatomic,strong) UIImageView *filterImageView;
/**  */
@property (nonatomic,strong) CoverBottomView *coverView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"滤镜demo";
    
    self.filterImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 100, 200, 150)];
    self.filterImageView.image = [UIImage imageNamed:@"bgImage"];
    [self.view addSubview:self.filterImageView];

    
    self.coverView = [[CoverBottomView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-140, SCREEN_WIDTH, 140)];
    self.coverView.delegate = self;
    [self.view addSubview:self.coverView];
}
#pragma CoverBottomViewDelegate
-(void)coverBottom:(CoverBottomView *)coverView didSelectModel:(FilterModel *)model{
    self.filterImageView.image = model.image;
}


@end
