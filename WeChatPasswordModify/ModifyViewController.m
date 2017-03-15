//
//  ModifyViewController.m
//  WeChatPasswordModify
//
//  Created by panchao on 17/3/14.
//  Copyright © 2017年 estar. All rights reserved.
//

#import "ModifyViewController.h"
#import "ViewController.h"

@interface ModifyViewController ()<ViewControllerDelegate>

@end

@implementation ModifyViewController
{
    UIScrollView *_scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;

    // UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.scrollEnabled = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;

    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(scrollView.frame);

    Component *component0 = [Component new];
    component0.descriptionTitle = @"请输入支付密码，以验证身份";

    ViewController *vc0 = [[ViewController alloc] init];
    [self addChildViewController:vc0];
    vc0.view.frame = scrollView.bounds;
    vc0.component = component0;
    vc0.delegate = self;
    [scrollView addSubview:vc0.view];

    Component *component1 = [Component new];
    component1.descriptionTitle = @"请设置微信支付密码，用于支付验证。";

    ViewController *vc1 = [[ViewController alloc] init];
    [self addChildViewController:vc1];
    vc1.view.frame = CGRectMake(width * 1, 0, width, height);
    vc1.component = component1;
    vc1.delegate = self;
    [scrollView addSubview:vc1.view];

    Component *component2 = [Component new];
    component2.descriptionTitle = @"请再次填写以确认";
    component2.actionTitle = @"你现在可以点我了";

    ViewController *vc2 = [[ViewController alloc] init];
    [self addChildViewController:vc2];
    vc2.view.frame = CGRectMake(width * 2, 0, width, height);
    vc2.component = component2;
    vc2.delegate = self;
    [scrollView addSubview:vc2.view];

    scrollView.contentSize = CGSizeMake(width * 3, height);
}

#pragma mark - view cotroller delegate

- (void)viewControllerDidDoneBtnClick:(ViewController *)vc {
    NSInteger index = [self.childViewControllers indexOfObject:vc];
    NSLog(@"当前是%ld控制器", index);

    // 只有最后一个控制器有完成
    // 此处判断前后是否匹配，若匹配调用修改支付密码接口

    // 取出前一个vc
    ViewController *preVc = self.childViewControllers[index-1];

    BOOL isMatching = [preVc.component.password isEqualToString:vc.component.password];
    if (isMatching) {
        // 调用修改支付密码接口
        NSLog(@"第一个密码：%@，第二个密码：%@，匹配！", preVc.component.password, vc.component.password);
    } else {
        NSLog(@"第一个密码：%@，第二个密码：%@，不匹配！", preVc.component.password, vc.component.password);
    }
}

- (void)viewController:(ViewController *)vc inputOverWithPassword:(NSString *)password {

    // 如果是第一个，那么就要调验证支付密码接口
    // 如果不是最后一个，就往后滑动一页
    // 如果是最后一个，就不做处理，因为点击完成的时候会处理

    if ([vc isEqual:self.childViewControllers.firstObject]) {

        // 调用支付密码接口
        NSLog(@"请调用验证支付密码接口！");
//        if (验证通过) {
//            // 往后滚一个
//            [self scrollViewScrollToNextPageFromCurrentPage:vc];
//        } else {
//            // 弹框提示支付密码错误
//            NSLog(@"支付密码错误！");
//        }

    } else if ([vc isEqual:self.childViewControllers.lastObject]) {
        // 不用管
    } else {
        [self scrollViewScrollToNextPageFromCurrentPage:vc];
    }
}

#pragma mark - private method

- (void)scrollViewScrollToNextPageFromCurrentPage:(ViewController *)vc {
    NSInteger index = [self.childViewControllers indexOfObject:vc];
    ViewController *nextVc = self.childViewControllers[index + 1];
    [nextVc.textfield becomeFirstResponder];
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    [_scrollView scrollRectToVisible:CGRectMake((index + 1) * width , 0, width, height) animated:YES];
}

@end
