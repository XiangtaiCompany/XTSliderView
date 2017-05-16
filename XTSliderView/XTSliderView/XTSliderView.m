//
//  TopOrderSelectView.m
//  颐惠商城
//
//  Created by XiangTaiMini on 15/8/27.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "XTSliderView.h"

@interface XTSliderView()

@property (nonatomic, copy) XTItemSelecedIndexBlock itemSelecedIndexBlock;
@property (nonatomic, strong) NSMutableArray *titleBtnArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomGapLine;
@property (nonatomic, strong) UIView *sliderLine;

@end

@implementation XTSliderView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUIFrame:frame andTitleArray:titles];
    }
    return self;
}

- (void)loadUIFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray
{
    if (!_titleBtnArray) {
        _titleBtnArray = [[NSMutableArray alloc] init];
    }
    
    self.rowMaxCount = 6;
    self.itemTitleNormalColor = [UIColor blackColor];
    self.itemTitleSelecedColor = [UIColor redColor];
    self.itemTitleFont = [UIFont systemFontOfSize:14];
    self.gapLineColor = [UIColor groupTableViewBackgroundColor];
    self.sliderLineColor = [UIColor redColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    for (int i = 0;  i < titleArray.count ; i++) {
       
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        titleBtn.tag = (i+1) * 333;
        titleBtn.titleLabel.font = self.itemTitleFont;
        [titleBtn setTitleColor:self.itemTitleNormalColor forState:UIControlStateNormal];
        [titleBtn setTitleColor:self.itemTitleSelecedColor forState:UIControlStateSelected];
        [titleBtn addTarget:self action:@selector(changeItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:titleBtn];
        
        if (i == 0) {
            titleBtn.selected = YES;
        }
        
        [_titleBtnArray addObject:titleBtn];
        
    }
    
    //分割线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = self.gapLineColor;
    [scrollView addSubview:bottomLine];
    self.bottomGapLine = bottomLine;
    
    //滑动的线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = self.sliderLineColor;
    [scrollView addSubview:lineView];
    self.sliderLine = lineView;
}

- (void)setItemTitleNormalColor:(UIColor *)itemTitleNormalColor {
    _itemTitleNormalColor = itemTitleNormalColor;
    for (UIButton *button in self.titleBtnArray) {
        [button setTitleColor:itemTitleNormalColor forState:UIControlStateNormal];
    }
}

- (void)setItemTitleSelecedColor:(UIColor *)itemTitleSelecedColor {
    _itemTitleSelecedColor = itemTitleSelecedColor;
    for (UIButton *button in self.titleBtnArray) {
        [button setTitleColor:itemTitleSelecedColor forState:UIControlStateSelected];
    }
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    _itemTitleFont = itemTitleFont;
    for (UIButton *button in self.titleBtnArray) {
        button.titleLabel.font = itemTitleFont;
    }
}

- (void)setGapLineColor:(UIColor *)gapLineColor {
    _gapLineColor = gapLineColor;
    self.bottomGapLine.backgroundColor = gapLineColor;
}

- (void)setSliderLineColor:(UIColor *)sliderLineColor {
    _sliderLineColor = sliderLineColor;
    self.sliderLine.backgroundColor = sliderLineColor;
}

- (void)setRowMaxCount:(NSUInteger)rowMaxCount {
    _rowMaxCount = rowMaxCount;
    [self layoutIfNeeded];
}

-(void)setTitles:(NSArray *)titles {
    _titles = titles;
    NSAssert(titles.count == self.titleBtnArray.count, @"titles count is not equal buttons count");

    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UIButton *button = _titleBtnArray[i];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

-(void)changeItem:(UIButton *)sender
{
    self.userInteractionEnabled = NO;
    
    for (UIButton *btn in _titleBtnArray) {
        btn.selected = NO;
    }

    sender.selected = YES;

    CGPoint center = CGPointMake(sender.center.x, self.sliderLine.center.y);
    
    //回调时间
    self.itemSelecedIndexBlock ? self.itemSelecedIndexBlock((sender.tag / 333) - 1) : nil;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.5 animations:^{
        self.sliderLine.center = center;
    } completion:^(BOOL finished) {
        if (finished == YES) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            self.userInteractionEnabled = YES;
        }
    }];
}

- (void)didSelectedButtonWithIndex:(NSInteger)index {
    NSString *result = [NSString stringWithFormat:@"index %ld beyond items count bounds [0...%ld]", index, self.titleBtnArray.count];
    NSAssert(index < self.titleBtnArray.count, result);
    UIButton *btn = [self viewWithTag:(index + 1) * 333];
    [self changeItem:btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat sW = CGRectGetWidth(self.frame);
    CGFloat sH = CGRectGetHeight(self.frame);
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) / self.rowMaxCount * self.titleBtnArray.count, 0);
    
    CGFloat btnW = sW / self.rowMaxCount;
    CGFloat btnH = sH - 1;
    if (self.titleBtnArray.count < self.rowMaxCount) {
        btnW = sW / self.titleBtnArray.count;
    }
    
    [self.titleBtnArray enumerateObjectsUsingBlock:^(UIButton *titleBtn, NSUInteger i, BOOL * _Nonnull stop) {
        titleBtn.frame = CGRectMake(btnW * i , 0, btnW, btnH);
    }];
    
    self.bottomGapLine.frame = CGRectMake(0, sH - 0.5, sW, 0.5);
    
    self.sliderLine.frame = CGRectMake(0, sH - 2, btnW, 2);
}

@end
