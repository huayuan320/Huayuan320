//
//  YGTPopItem.m
//  yougutu
//
//  Created by 赵晨宇 on 16/7/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "YGTPopItem.h"

@implementation YGTPopItem
-(instancetype)initWithImage:(NSString *)imageStr content:(NSString *)content block:(YGTPopItemBlock)block
{
    if (self = [super init]) {
        self.imageStr = imageStr;
        self.contentStr = content;
        self.clickBlock = block;
    }
    return self;
}
@end
