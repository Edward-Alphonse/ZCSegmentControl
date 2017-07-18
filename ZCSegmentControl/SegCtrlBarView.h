//
//  SegCtrlView.h
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/6.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegCtrlItem.h"

@protocol SegCtrlBarViewDelegate <NSObject>

- (void)didSelectItemWithIndex:(NSInteger)index;

@end


@interface SegCtrlBarView : UIView<UITableViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id<SegCtrlBarViewDelegate> delegate;

@property (nonatomic, strong) UIColor *textNormalColor;
@property (nonatomic, strong) UIColor *textSelectedColor;

- (instancetype)initWithFrame:(CGRect)frame isScrollable:(BOOL)isScrollable;

@end
