//
//  SegCtrlView.m
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/6.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "SegCtrlBarView.h"

#import "ConstDef.h"
#import "UIView+Size.h"



@interface SegCtrlBarView ()

@property (nonatomic, strong) UIScrollView *segScrollBar;
@property (nonatomic, strong) UIView *segScrollIndicator;
@property (nonatomic, strong) SegCtrlItem *currentItem;
@property (nonatomic, strong) SegCtrlItem *nextItem;
@property (nonatomic, assign) BOOL isScroollable;

@end

@implementation SegCtrlBarView

//static CGFloat ItemW = 0.0;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self layoutItems];
    
    _currentItem = [self.segScrollBar viewWithTag:TAG + _currentIndex];
    
    CGRect frame = CGRectMake(_currentItem.x, self.height - INDICATOR_HEIGHT, _currentItem.width, INDICATOR_HEIGHT);
    [self.segScrollIndicator setFrame:frame];
    
    [self scrollToNextItemAnimation:_currentItem];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame isScrollable:NO];
}

- (instancetype)initWithFrame:(CGRect)frame isScrollable:(BOOL)isScrollable {
    self = [super initWithFrame:frame];
    if(self) {
        _segScrollBar = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _segScrollBar.showsVerticalScrollIndicator = NO;
        _segScrollBar.showsHorizontalScrollIndicator = NO;
        _segScrollBar.bounces = NO;
        [self addSubview:_segScrollBar];
        
        _segScrollIndicator = [[UIView alloc]initWithFrame:CGRectZero];
        _segScrollIndicator.backgroundColor = [UIColor blueColor];
        [_segScrollBar addSubview:_segScrollIndicator];
        
        _currentIndex = 0;
        _isScroollable = isScrollable;
        _textNormalColor = [UIColor blackColor];
        _textSelectedColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutItems {
    CGFloat itemX = 0.0;
    if(_isScroollable) {
        for(int i = 0; i < _titles.count; i++) {
            NSString *title = _titles[i];
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SEGCTRLITEM_FONT} context:nil].size;
            SegCtrlItem *item = [[SegCtrlItem alloc]initWithFrame:CGRectMake(itemX, 0, titleSize.width + SEGCTRLITEM_MARGIN, self.height)];
            item.text = _titles[i];
            item.textNormalColor = _textNormalColor;
            item.textSelectedColor = _textSelectedColor;
            item.tag = TAG + i;
            item.status = (_currentIndex == i) ? SegCtrlStatusSelected : SegCtrlStatusNormal;
            [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            [self.segScrollBar addSubview:item];
            itemX += item.width;
        }
        CGFloat contentWidth = itemX;
        self.segScrollBar.contentSize = CGSizeMake(contentWidth, self.height);
    }
    else {
        CGFloat itemW = SCREEN_WIDTH / _titles.count;
        
        for(int i = 0; i < _titles.count; i++) {
            itemX = i * itemW;
            SegCtrlItem *item = [[SegCtrlItem alloc]initWithFrame:CGRectMake(itemX, 0, itemW, self.height)];
            item.text = _titles[i];
            item.textNormalColor = _textNormalColor;
            item.textSelectedColor = _textSelectedColor;
            item.tag = TAG + i;
            item.status = (_currentIndex == i) ? SegCtrlStatusSelected : SegCtrlStatusNormal;
            [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            [self.segScrollBar addSubview:item];
        }
        self.segScrollBar.contentSize = CGSizeMake(self.width, self.height);
    }
}

//选择了item
- (void)selectItem:(SegCtrlItem *)sender {
    _currentIndex = sender.tag - TAG;
    [self scrollToNextItemAnimation:sender];
    if(_delegate && [_delegate respondsToSelector:@selector(didSelectItemWithIndex:)]) {
        [_delegate didSelectItemWithIndex:_currentIndex];
    }
}

//移动到选择的item
- (void)scrollToNextItemAnimation:(SegCtrlItem *)nextItem {
    [UIView animateWithDuration:0.5 animations:^{
        [_segScrollIndicator setX:nextItem.x];
        nextItem.status = SegCtrlStatusSelected;
        _currentItem.status = SegCtrlStatusNormal;
        [self.segScrollIndicator setWidth:nextItem.width];
        [self moveItemToFocusPosition:nextItem];
        
    }];
    _currentItem = nextItem;
}

//设置选择的Item
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    //光标移动到当前的item
    SegCtrlItem *item = [self itemForIndex:currentIndex];
    if(item) {
        [self scrollToNextItemAnimation:item];
    }
}

//根据index查找对应的item
- (SegCtrlItem *)itemForIndex:(NSInteger)index {
    for (UIView *subView in [self.segScrollBar subviews]) {
        if([subView isKindOfClass:[SegCtrlItem class]]) {
            SegCtrlItem *item = (SegCtrlItem *)subView;
            if(item.tag - TAG == index) {
                return item;
            }
        }
    }
    return nil;
}


- (void)moveItemToFocusPosition:(SegCtrlItem *)item{
    CGFloat offSetX = item.centerX;
    if(offSetX > self.width / 2) {
        offSetX = item.centerX - self.width/2;
        if(offSetX > (self.segScrollBar.contentSize.width - self.width)) {
            offSetX = self.segScrollBar.contentSize.width - self.width;
        }
    }
    else {
        offSetX = 0.0;
    }
    [_segScrollBar setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}


@end
