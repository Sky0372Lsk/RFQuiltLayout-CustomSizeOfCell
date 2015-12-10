//
//  RFQuiltLayout.h
//  
//  Created by Bryce Redd on 12/7/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RFQuiltLayoutDelegate <UICollectionViewDelegate>
@optional
//传尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath; // defaults to 1x1
//传上下左右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath; // defaults to uiedgeinsetszero
@end

@interface RFQuiltLayout : UICollectionViewLayout
@property (nonatomic, weak) IBOutlet NSObject<RFQuiltLayoutDelegate>* delegate;

@property (nonatomic, assign) CGSize blockPixels; // defaults to 100x100、//块像素，我的设置成1*1
//代表倍数，比如原版本设置的是返回来1、2或者3；也就是比例1：2：3   满屏宽度显示五分，比例为1：1：1：1：1或者1：1：2：1或者1：2：2或者1：3等等，故原作者将blockPixels设置成CGSizeMake(75,75)，五份正好是375
//设置成1*1

@property (nonatomic, assign) UICollectionViewScrollDirection direction; // defaults to vertical

// only use this if you don't have more than 1000ish items.小于1000个
// this will give you the correct size from the start and
// improve scrolling speed, at the cost of time at the beginning
//这将给你正确的大小从开始和提高滚动速度，在开始的时间成本
@property (nonatomic) BOOL prelayoutEverything; //重新布局一切

@end
