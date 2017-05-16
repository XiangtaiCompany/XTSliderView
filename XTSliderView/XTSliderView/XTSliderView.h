//
//  TopOrderSelectView.h
//  颐惠商城
//
//  Created by XiangTaiMini on 15/8/27.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^XTItemSelecedIndexBlock)(NSInteger index);

@interface XTSliderView : UIView
/**
 init method

 @param frame frame
 @param titles item titles
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
/**
 item selected block

 @param itemSelecedIndexBlock block
 */
- (void)setItemSelecedIndexBlock:(XTItemSelecedIndexBlock)itemSelecedIndexBlock;
/**
 custom slected item, if you want selected item which you want to

 @param index item index
 */
- (void)didSelectedButtonWithIndex:(NSInteger)index;
/**
 row max count, default 6
 */
@property (nonatomic, assign) NSUInteger rowMaxCount;
/**
 titles, if you want to change init method titles
 */
@property (nonatomic, nullable, strong) NSArray *titles;
/**
 item title normal color, default black color
 */
@property (nonatomic, nullable, strong) UIColor *itemTitleNormalColor;
/**
 item title selected color, default red color
 */
@property (nonatomic, nullable, strong) UIColor *itemTitleSelecedColor;
/**
 item title font, default [UIFont systemFontOfSize:14]
 */
@property (nonatomic, nullable, strong) UIFont *itemTitleFont;
/**
 gapLineColor, default [UIColor groupTableViewBackgroundColor]
 */
@property (nonatomic, nullable, strong) UIColor *gapLineColor;
/**
 sliderLineColorr, default red color
 */
@property (nonatomic, nullable, strong) UIColor *sliderLineColor;

@end
NS_ASSUME_NONNULL_END
