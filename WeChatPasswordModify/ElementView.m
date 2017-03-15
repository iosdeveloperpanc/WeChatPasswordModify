//
//  ElementView.m
//  WeChatPasswordModify
//
//  Created by panchao on 17/3/14.
//  Copyright © 2017年 estar. All rights reserved.
//

#import "ElementView.h"

@implementation ElementView

- (void)drawRect:(CGRect)rect {

    CGFloat radius = 5;
    CGFloat centerX = rect.size.width/2;
    CGFloat centerY = rect.size.height/2;

    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2)];

    UIColor *color;

    if (self.isInput) {
        color = [UIColor blackColor];
    } else {
        color = [UIColor clearColor];
    }

    [color set];

    [path fill];

    // 边线
    if (self.isLastOne) {
        return;
    }

    CGFloat lineWidth = 1;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = lineWidth;
    [path1 moveToPoint:CGPointMake(rect.size.width - lineWidth/2, 0)];
    [path1 addLineToPoint:CGPointMake(rect.size.width - lineWidth/2, rect.size.height)];
    [[UIColor lightGrayColor] set];
    [path1 stroke];
}

- (void)setInput:(BOOL)input {
    _input = input;

    [self setNeedsDisplay];
}

- (void)setLastOne:(BOOL)lastOne {
    _lastOne = lastOne;

    [self setNeedsDisplay];
}

@end
