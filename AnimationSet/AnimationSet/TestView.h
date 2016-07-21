//
//  TestView.h
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/21.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AgreeBlock)();

@interface TestView : UIView
@property (nonatomic, copy) AgreeBlock agreeBlock;

/** 弹出 */
- (void)showInView:(UIView *)view;

/**
 *  隐藏视图
 */
- (void)hidenView;


@end
