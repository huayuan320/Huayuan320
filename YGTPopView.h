//
//  YGTPopView.h
//  yougutu
//
//  Created by 赵晨宇 on 16/7/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGTPopItem.h"
@interface YGTPopView : UIView
/**
 *  初始化方法
 *
 *  @param arr 需要展示的内容数组
 *
 *  @return view对象
 */
- (instancetype)initWithItems:(NSArray *)arr;
- (void)showOnView:(UIView *)supView;
@end
