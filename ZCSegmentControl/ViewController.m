//
//  ViewController.m
//  ZCSegmentControl
//
//  Created by QITMAC000242 on 17/2/6.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "ViewController.h"
#import "SegCtrlBarView.h"
#import "SegCtrlScrollView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"

#import "ConstDef.h"
#import "UIView+Size.h"

@interface Object : NSObject<NSCopying>

@property (nonatomic, assign)NSInteger num;

@end
@implementation Object

- (id)copyWithZone:(nullable NSZone *)zone {
    Object *newObj = [Object new];
    newObj.num = _num;
    return newObj;
}

@end

@interface ViewController () <SegCtrlBarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *titles = @[@"第一页", @"第二页ssss", @"第三页", @"第四页", @"第五页", @"第六页zzzzzzzzzz"];
    
//    [self setupSegCtrlBar:titles];
    [self setupSegCtrlContentView:titles];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupSegCtrlBar:(NSArray *)array {
    SegCtrlBarView *segCtrlBarView = [[SegCtrlBarView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 50) isScrollable:NO];
    [segCtrlBarView setTitles:array];
    
    
    segCtrlBarView.delegate = self;
    [self.view addSubview:segCtrlBarView];
}

- (void)setupSegCtrlContentView:(NSArray *)array {
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    FourthViewController *fourthVC = [[FourthViewController alloc]init];
    FifthViewController *fifthVC = [[FifthViewController alloc]init];
    SixthViewController *sixthVC = [[SixthViewController alloc]init];
    
    SegCtrlScrollView *segCtrlScrollView = [[SegCtrlScrollView alloc]initScrollSegCtrlBarWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) isViewScrollable:YES];
    [segCtrlScrollView setSegItemTitles:array];
    [segCtrlScrollView setViewControllers:@[firstVC, secondVC, thirdVC, fourthVC, fifthVC, sixthVC]];
    [self.view addSubview:segCtrlScrollView];

}

#pragma mark -SegCtrlBarViewDelegate
- (void)didSelectItemWithIndex:(NSInteger)index {
    NSLog(@"123456");
}



@end
