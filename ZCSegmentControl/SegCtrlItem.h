//
//  SegCtrlItem.h
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/6.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SegCtrlStatus) {
    SegCtrlStatusNormal,
    SegCtrlStatusSelected,
};

@interface SegCtrlItem : UIControl

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UILabel *textLabel;


@property (nonatomic, strong) UIColor *textNormalColor;
@property (nonatomic, strong) UIColor *textSelectedColor;
@property (nonatomic, assign) SegCtrlStatus status;

@end
