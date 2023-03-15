//
//  IGConfigItem.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "IGConfigItem.h"

@implementation IGConfigItem

+ (instancetype)configItem:(NSString *)title
        viewControllerName:(NSString *)viewControllerName {
    return [[self alloc] initItemWithTitle:title viewControllerName:viewControllerName];
}

// MARK: - Private Methods

- (instancetype)initItemWithTitle:(NSString *)title
               viewControllerName:(NSString *)viewControllerName {
    self = [super init];
    if (self) {
        _title = title;
        _viewControllerName = viewControllerName;
    }
    return self;
}

// MARK: - IGListDiffable

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return [self isEqual:object];
}

@end
