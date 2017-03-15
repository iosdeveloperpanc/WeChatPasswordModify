//
//  ViewController.h
//  WeChatPasswordModify
//
//  Created by panchao on 17/3/14.
//  Copyright © 2017年 estar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Component.h"

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

@optional
- (void)viewControllerDidDoneBtnClick:(ViewController *)vc;
- (void)viewController:(ViewController *)vc inputOverWithPassword:(NSString *)password;

@end

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (nonatomic, strong) Component *component;
@property (nonatomic, weak) id<ViewControllerDelegate> delegate;

@end
