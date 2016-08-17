//
//  YGTPopCell.m
//  yougutu
//
//  Created by 赵晨宇 on 16/7/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "YGTPopCell.h"
#import "YGTPopItem.h"
@interface YGTPopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end
@implementation YGTPopCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
- (void)setAppData:(YGTPopItem *)appData
{
    _appData = appData;
    _imageView.image = IMAGE(appData.imageStr);
    _contentLable.text = appData.contentStr;
}
@end
