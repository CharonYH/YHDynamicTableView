//
//  IGConfigItem.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import <Foundation/Foundation.h>
#import <IGListDiffKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGConfigItem : NSObject <IGListDiffable>

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, nullable, readonly) NSString *viewControllerName;

+ (instancetype)configItem:(nullable NSString *)title
        viewControllerName:(nullable NSString *)viewControllerName;

@end

NS_ASSUME_NONNULL_END
