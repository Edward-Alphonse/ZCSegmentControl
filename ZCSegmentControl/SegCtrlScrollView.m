//
//  SegCtrScrollView.m
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/7.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "SegCtrlScrollView.h"
#import "FirstViewController.h"

#import "ConstDef.h"
#import "UIView+Size.h"

@interface SegCtrlScrollView () <UIScrollViewDelegate, SegCtrlBarViewDelegate>


@property (nonatomic, strong) SegCtrlBarView *segCtrlBar;
@property (nonatomic, strong) UIScrollView *scrollContentView;

@end

@implementation SegCtrlScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_segCtrlBar setCurrentIndex:_currentIndex];
    [self layoutContentView:_currentIndex];
    
    self.scrollContentView.contentOffset = CGPointMake(_currentIndex * self.width, 0);
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame isViewScrollable:YES isSegCtrlBarScrollable:NO];
}

- (instancetype)initWithFrame:(CGRect)frame isViewScrollable:(BOOL)isViewScrollable isSegCtrlBarScrollable:(BOOL) isBarScrollable{
    self = [super initWithFrame:frame];
    if(self) {
        _segCtrlBar = [[SegCtrlBarView alloc]initWithFrame:CGRectMake(0, 40, self.width, 50) isScrollable:isBarScrollable];
        _segCtrlBar.delegate = self;
        [self addSubview:_segCtrlBar];
        
        _scrollContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _segCtrlBar.bottom, self.width, self.height - _segCtrlBar.bottom)];
        _scrollContentView.bounces = NO;
        _scrollContentView.showsVerticalScrollIndicator = NO;
        _scrollContentView.showsHorizontalScrollIndicator = NO;
        _scrollContentView.delegate = self;
        _scrollContentView.pagingEnabled = YES;
        [self addSubview:_scrollContentView];
        
        _isViewScrollable = isViewScrollable;
        _currentIndex = 4;
    }
    return self;
}


- (instancetype)initScrollSegCtrlBarWithFrame:(CGRect)frame isViewScrollable:(BOOL)isViewScrollable {
    return [self initWithFrame:frame isViewScrollable:isViewScrollable isSegCtrlBarScrollable:YES];
}

- (instancetype)initStaticSegCtrlBarWithFrame:(CGRect)frame isViewScrollable:(BOOL)isViewScrollable {
    return [self initWithFrame:frame isViewScrollable:isViewScrollable isSegCtrlBarScrollable:NO];
}

- (void)setSegItemTitles:(NSArray<NSString *> *)titles {
    [self.segCtrlBar setTitles:titles];
}

- (void)layoutContentView:(NSInteger)index {
    UIViewController *vc = _viewControllers[index];
    if([vc isViewLoaded]) {
        return ;
    }
    vc.view.frame = CGRectMake(index * self.width, 0, _scrollContentView.width, _scrollContentView.height);
    [self.scrollContentView addSubview:vc.view];
    self.scrollContentView.contentSize = CGSizeMake(_viewControllers.count * _scrollContentView.width, _scrollContentView.height);
    [self addViewController:vc];
}

- (void)addViewController:(UIViewController *)vc {
    UIResponder *next = self.nextResponder;
    while(next != nil) {
        if([next isKindOfClass:[UIViewController class]]) {
            UIViewController *superVC = (UIViewController *)next;
            [superVC addChildViewController:vc];
            break;
        }
        next = next.nextResponder;
    }
}

- (void)layoutSegCtrlItem:(NSInteger)index {
    [_segCtrlBar setCurrentIndex:index];
}

- (void)setSegCtrlBarViewFrame:(CGRect )frame {
    [_segCtrlBar setFrame:frame];
    [_scrollContentView setFrame:CGRectMake(0, _segCtrlBar.bottom, _scrollContentView.width, self.height-_segCtrlBar.bottom)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat selectedIndex = ceil(fabs(scrollView.contentOffset.x / _scrollContentView.width));
    [self layoutContentView:selectedIndex];
    [self layoutSegCtrlItem:selectedIndex];
}

#pragma mark -SegCtrlBarViewDelegate

- (void)didSelectItemWithIndex:(NSInteger)index {
    if(_isViewScrollable) {
        [self layoutContentView:index];
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollContentView.contentOffset = CGPointMake(index * self.width, 0);
        }];
    }
    else {
        self.scrollContentView.scrollEnabled = NO;
        self.scrollContentView.contentOffset = CGPointMake(index * self.width, 0);
    }
}

@end
