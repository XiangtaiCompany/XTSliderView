//
//  ViewController.m
//  XTSliderView
//
//  Created by 何凯楠 on 2017/5/16.
//  Copyright © 2017年 HeXiaoBa. All rights reserved.
//

#import "ViewController.h"
#import "XTSliderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGRect frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 60);
    XTSliderView *view = [[XTSliderView alloc] initWithFrame:frame titles:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7"]];
    view.rowMaxCount = 4;
    view.itemTitleNormalColor = [UIColor purpleColor];
    view.itemTitleSelecedColor = [UIColor cyanColor];
    view.itemTitleFont = [UIFont systemFontOfSize:18];
    view.gapLineColor = [UIColor yellowColor];
    view.sliderLineColor = [UIColor orangeColor];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    view.titles = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g"];
    [view setItemSelecedIndexBlock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    [view didSelectedButtonWithIndex:2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
