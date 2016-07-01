//
//  ViewController.h
//  Demo
//
//  Created by canye on 16/6/15.
//  Copyright © 2016年 jingyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookCollectionViewCell;
@interface ViewController : UIViewController

@property (strong, nonatomic) BookCollectionViewCell *bookCell;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@end

