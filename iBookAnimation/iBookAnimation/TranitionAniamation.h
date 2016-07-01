//
//  TranitionAniamation.h
//  Demo
//
//  Created by jingyu on 16/6/16.
//  Copyright © 2016年 jingyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PageTransitionType) {
    PageTransitionTypePush = 0,
    PageTransitionTypePop
};
@interface TranitionAniamation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) PageTransitionType type;

+ (instancetype)transitionWithType:(PageTransitionType)type;
- (instancetype)initWithTransitionType:(PageTransitionType)type;
@end
