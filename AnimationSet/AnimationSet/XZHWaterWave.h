//
//  XZHWaterWave.h
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/20.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XZHWaterWave;
@protocol XZHWaterWaveDelegate <NSObject>
/**
 *  返回贝塞尔曲线路径
 *
 *  @param waterWave 水波工具
 *  @param path      路径
 */
- (void)waterWave:(XZHWaterWave *)waterWave wavePath:(UIBezierPath *)path;
@end

@interface XZHWaterWave : NSObject
/**
 *  frame 要与设置的视图一致
 */
- (id)initWithFrame:(CGRect)frame;


/**
 *  水深占比，0 to 1
 */
@property(nonatomic, assign) CGFloat waterDepth;
/** 代理 */
@property (nonatomic, weak) id<XZHWaterWaveDelegate> delegate;

@end
