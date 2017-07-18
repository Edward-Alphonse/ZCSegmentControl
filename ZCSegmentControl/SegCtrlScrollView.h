//
//  SegCtrScrollView.h
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/7.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SegCtrlBarView.h"

@interface SegCtrlScrollView : UIView

@property (nonatomic, assign) BOOL isViewScrollable;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initScrollSegCtrlBarWithFrame:(CGRect)frame isViewScrollable:(BOOL) isViewScrollable;
- (instancetype)initStaticSegCtrlBarWithFrame:(CGRect)frame isViewScrollable:(BOOL) isViewScrollable;

- (void)setSegItemTitles:(NSArray<NSString *> *)titles;
- (void)setSegCtrlBarViewFrame:(CGRect )frame;
@end
