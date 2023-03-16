//
//  UIView+YHExtention.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/16.
//

#import "UIView+YHExtention.h"

@implementation UIView (YHExtention)

- (nullable UIViewController *)ex_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = view.nextResponder;
        if ([nextResponder isKindOfClass:UIViewController.class]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
