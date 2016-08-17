//
//  YGTPopView.m
//  yougutu
//
//  Created by 赵晨宇 on 16/7/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "YGTPopView.h"
#import "YGTPopCell.h"
#define cellHeight 65
#define TopMargin  40
#define kCell @"cell"
@interface YGTPopView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSArray *itemArr;
//背景view
@property (nonatomic,strong)UIView *backGrondView;
@property (nonatomic,strong)UIView *popView;
@property (nonatomic,strong)UIButton *buttomView;
@end
@implementation YGTPopView
-(instancetype)initWithItems:(NSArray *)arr
{
    if (self = [super init]) {
        //这里讲一下为什么不在这里去给界面添加东西呢，主要有两个原因（1）初始化的时候尽量不要搞那么多操作（2）为了以后方便给这个view添加属性，比如动画的样式什么的
        self.itemArr = arr;
    }
    return self;
}
- (void)showOnView:(UIView *)supView
{
    
    self.frame = supView.bounds;
    _backGrondView = [[UIView alloc]init];
    _backGrondView.frame = self.bounds;
    _backGrondView.backgroundColor = [UIColor blackColor];
    _backGrondView.alpha = 0.5;
    [self addSubview:_backGrondView];
    __block BOOL isAdd = YES;
    [supView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            isAdd = NO;
        }
    }];
    if (isAdd) {
        [supView addSubview:self];
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_backGrondView addGestureRecognizer:singleTap];
    CGFloat height = ((_itemArr.count + 1) / 4 + 1) * (cellHeight + 10) + 60 + TopMargin;
    _popView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) + height, self.mj_w, height)];
    _popView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_popView];
    [self buildUpPopView];
}
- (void)buildUpPopView
{
    // 设置CollectionView的布局方式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 创建CollectionView
    
    CGFloat height = ((_itemArr.count + 1) / 4 + 1) * (cellHeight + 10);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopMargin / 2, self.mj_w, height) collectionViewLayout:flowLayout];
    
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    // 要遵守三个协议，但这里写两个就可以（只有两个代理需要设置）
    collectionView.delegate = self;
    collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"YGTPopCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:kCell];
    [_popView addSubview:collectionView];
#pragma mark------底部按钮视图------
    _buttomView = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame) + TopMargin / 2, self.mj_w, 60)];
    _buttomView.backgroundColor = [UIColor whiteColor];
    [_popView addSubview:_buttomView];
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.backgroundColor = [UIColor redColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 20;
    [_buttomView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_buttomView);
        make.size.mas_equalTo(CGSizeMake(MAX_SCREEN_WIDTH - 60, 40));
    }];
    UIImageView *lineView = [[UIImageView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_buttomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_buttomView);
        make.height.equalTo(@1);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _popView.frame =  CGRectMake(0, self.mj_h - height - 60 - TopMargin, self.mj_w, height + 60+TopMargin);
    }];
}
#pragma mark------collectionView代理方法---------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGTPopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    YGTPopItem *item = _itemArr[indexPath.row];
    cell.appData = item;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss];
    YGTPopItem *item = _itemArr[indexPath.row];
    //防止外面item在初始化的时候block传nil导致的崩溃
    if (item.clickBlock) {
        item.clickBlock(indexPath.row);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((MAX_SCREEN_WIDTH - 50)/4, cellHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}
@end
