//
//  UIView+WaterWave.h
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/20.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WaterWave)
/**
 *  进行水波动画
 *
 *  @param depth 水波深度
 */
- (void)waterWaveAnimateWithDepth:(CGFloat)depth;
//必须要调用此方法，内部使用了定时器，导致内存无法释放
- (void)stopWave;
@end
