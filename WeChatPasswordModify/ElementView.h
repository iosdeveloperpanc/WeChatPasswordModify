//
//  ElementView.h
//  WeChatPasswordModify
//
//  Created by panchao on 17/3/14.
//  Copyright © 2017年 estar. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface ElementView : UIView

@property (nonatomic, assign, getter=isInput) BOOL input;
@property (nonatomic, assign, getter=isLastOne) BOOL lastOne;

@end
