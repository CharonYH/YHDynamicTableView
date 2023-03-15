//
//  YHDynamicTableViewDefine.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import <UIKit/UIKit.h>

#ifndef YHDynamicTableViewDefine_h
#define YHDynamicTableViewDefine_h

NS_INLINE CGFloat Status_Bar_Height(void) {
    if (@available(iOS 11.0,*)) {
        UIWindow *mainView = [UIApplication sharedApplication].keyWindow;
        return mainView.safeAreaInsets.top;
    }else{
        return 20.0f;
    }
}

NS_INLINE CGFloat Status_And_Navigation_Height(void) {
    return Status_Bar_Height() + 44;
}

#define YHRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define YHRandomColor YHRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)

#define YHScreenSize   [UIScreen mainScreen].bounds
#define YHScreenWidth  YHScreenSize.size.width

#endif /* YHDynamicTableViewDefine_h */
