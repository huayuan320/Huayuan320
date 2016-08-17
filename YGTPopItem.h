//
//  YGTPopItem.h
//  yougutu
//
//  Created by 赵晨宇 on 16/7/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^YGTPopItemBlock)(NSInteger index);
@interface YGTPopItem : NSObject
@property (nonatomic, copy)YGTPopItemBlock clickBlock;
//每个iten的文字
@property (nonatomic, copy)NSString *imageStr;
//每个item的内容
@property (nonatomic, copy)NSString *contentStr;
/**
 *  每个item的初始化方法
 *
 *  @param imageStr 图片
 *  @param content  内容
 *  @param block    点击事件
 *
 *  @return item对象
 */
- (instancetype)initWithImage:(NSString *)imageStr content:(NSString *)content block:(YGTPopItemBlock)block;
@end
