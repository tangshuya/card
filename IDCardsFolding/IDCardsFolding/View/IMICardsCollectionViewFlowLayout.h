//
//  IMICardsCollectionViewFlowLayout.h
//  WifireVportProject
//
//  Created by 汤书亚 on 2018/9/27.
//  Copyright © 2018年 Wifire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMICardsCollectionViewCell.h"

@class IMICardsCollectionViewFlowLayout;
@protocol CollectionViewFlowLayoutDelagate <NSObject>

- (void)collectionViewFlowLayout:(IMICardsCollectionViewFlowLayout *)flowLayout moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

@end
@interface IMICardsCollectionViewFlowLayout : UICollectionViewFlowLayout<CollectionViewCellGestureDelegate>
@property(weak, nonatomic) id<CollectionViewFlowLayoutDelagate> delagate;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
