//
//  SegCtrlItem.m
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/6.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "SegCtrlItem.h"

#import "ConstDef.h"
#import "UIView+Size.h"

@implementation SegCtrlItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    [self textColorWithStatus:_status];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = _textNormalColor;
        self.textLabel.font = SEGCTRLITEM_FONT;
        [self addSubview:_textLabel];
        
        _status = SegCtrlStatusNormal;
        _textNormalColor = [UIColor blackColor];
        _textSelectedColor = [UIColor redColor];
    }
    return self;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
}

- (void)setStatus:(SegCtrlStatus)status {
    _status = status;
    [self textColorWithStatus:status];
}

- (void)textColorWithStatus:(SegCtrlStatus)status {
    CGFloat textScaling = 1;
    if(status == SegCtrlStatusNormal) {
        _textLabel.textColor = _textNormalColor;
       
    }
    else {
        _textLabel.textColor = _textSelectedColor;
        textScaling = 1.1;
    }
    self.textLabel.transform = CGAffineTransformMakeScale(textScaling, textScaling);
}

@end
