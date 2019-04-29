//
//  IMICardsCollectionViewCell.h
//  WifireVportProject
//
//  Created by 汤书亚 on 2018/9/27.
//  Copyright © 2018年 Wifire. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMICardsCollectionViewCell;
@protocol CollectionViewCellGestureDelegate <NSObject>
- (void)collectionViewCell:(IMICardsCollectionViewCell *)cell handlerLongPressGesture:(UILongPressGestureRecognizer *)ges;
- (void)collectionViewCell:(IMICardsCollectionViewCell *)cell handlerPanGesture:(UIPanGestureRecognizer *)ges;
@end

@interface IMICardsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSMutableDictionary *dataModel;
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;
@property(weak, nonatomic) id<CollectionViewCellGestureDelegate> gestureDelagate;
@end
