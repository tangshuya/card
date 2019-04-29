//
//  TSYVipViewController.m
//  IDCardsFolding
//
//  Created by aaa on 2019/4/25.
//  Copyright © 2019 TangShuya. All rights reserved.
//


// 子控制器--vip会员
#import "TSYVipViewController.h"
#import "IMICardsCollectionViewCell.h"
#import "IMICardsCollectionViewFlowLayout.h"

//屏幕 rect
#define SCREEN_RECT     ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
static NSString * const liveCellId = @"liveId";
@interface TSYVipViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewFlowLayoutDelagate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IMICardsCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary*> *dataSource;

@end

@implementation TSYVipViewController


- (NSArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        self.flowLayout = [[IMICardsCollectionViewFlowLayout alloc] init];
        self.flowLayout.delagate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+50+10, SCREEN_WIDTH,SCREEN_HEIGHT-64) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 10, 30);
        [_collectionView registerNib:[UINib nibWithNibName:@"IMICardsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:liveCellId];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.collectionView];
    [self reloadCardsData];
    //    根据服务器请求展示几张卡片
    //    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    //    for (int i = 0; i < 5; i++) {
    //        [self.dataSource addObject:[NSString stringWithFormat:@"%d", i]];
    //    }
    //    [self.collectionView reloadData];
    
}
-(void)reloadCardsData{
    // 测试数据
    NSArray *array = @[
                       
       @{@"title":@"会员",@"descTitle":@"东建世纪广场",@"numbers":@"000025653786231",@"createTime":@"2018.02.19"}
                       ];
    self.dataSource = [NSMutableArray arrayWithArray:array];
    [self.collectionView reloadData];
}
#pragma mark -- -- -- -- -- - UICollectView Delegate & DataSource - -- -- -- -- --
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IMICardsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:liveCellId forIndexPath:indexPath];
    cell.gestureDelagate = self.flowLayout;
    cell.dataModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.flowLayout collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark -
#pragma mark -- -- -- -- -- - CollectionViewFlowLayout Delegate - -- -- -- -- --
- (void)collectionViewFlowLayout:(IMICardsCollectionViewFlowLayout *)flowLayout moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    [self.dataSource exchangeObjectAtIndex:indexPath.item withObjectAtIndex:newIndexPath.item];
}


@end
