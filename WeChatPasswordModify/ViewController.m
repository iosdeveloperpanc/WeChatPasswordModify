//
//  ViewController.m
//  WeChatPasswordModify
//
//  Created by panchao on 17/3/14.
//  Copyright © 2017年 estar. All rights reserved.
//

#import "ViewController.h"
#import "ElementView.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ElementView *elementView0;
@property (weak, nonatomic) IBOutlet ElementView *elementView1;
@property (weak, nonatomic) IBOutlet ElementView *elementView2;
@property (weak, nonatomic) IBOutlet ElementView *elementView3;
@property (weak, nonatomic) IBOutlet ElementView *elementView4;
@property (weak, nonatomic) IBOutlet ElementView *elementView5;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSArray *elementViews;

@end

@implementation ViewController

- (NSArray *)elementViews {
    if (!_elementViews) {
        _elementViews = @[self.elementView0, self.elementView1, self.elementView2, self.elementView3, self.elementView4, self.elementView5];
    }
    return _elementViews;
}

- (void)setComponent:(Component *)component {
    _component = component;

    self.titleLabel.text = component.descriptionTitle;
    self.doneBtn.hidden = !component.actionTitle;
    [self.doneBtn setTitle:component.actionTitle forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    ElementView *elementView = self.elementViews.lastObject;
    elementView.lastOne = YES;

    self.doneBtn.enabled = NO;
    [self.textfield becomeFirstResponder];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textChanged {

    if (!self.textfield.isFirstResponder) {
        return;
    }

    for (ElementView *elementView in self.elementViews) {
        NSInteger index = [self.elementViews indexOfObject:elementView];
        elementView.input = (index < self.textfield.text.length);
    }

    if (self.component.actionTitle) {
        self.doneBtn.enabled = self.textfield.text.length == 6;
    }

    if (self.textfield.text.length == 6) {
        self.component.password = self.textfield.text;
        if ([self.delegate respondsToSelector:@selector(viewController:inputOverWithPassword:)]) {
            [self.delegate viewController:self inputOverWithPassword:self.component.password];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)click {
    if ([self.delegate respondsToSelector:@selector(viewControllerDidDoneBtnClick:)]) {
        [self.delegate viewControllerDidDoneBtnClick:self];
    }
}

#pragma mark - text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if(string.length == 0)
    return YES;

    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if(existedLength - selectedLength + replaceLength > 6) {
        return NO;
    }

    return YES;
}

@end
