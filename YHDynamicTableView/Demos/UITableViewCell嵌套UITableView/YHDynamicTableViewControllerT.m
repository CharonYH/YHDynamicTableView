//
//  YHDynamicTableViewControllerT.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/16.
//

#import "YHDynamicTableViewControllerT.h"
#import "YHDynamicTableViewDefine.h"
#import "YHDynamicTableViewCellT.h"
#import <Masonry/Masonry.h>

@interface YHDynamicTableViewControllerT ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *dynamicTableView;
@property (nonatomic, strong) NSArray <NSArray <NSString *> *> *dataSource;

@end

@implementation YHDynamicTableViewControllerT

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHDynamicTableViewCellT *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(YHDynamicTableViewCellT.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius = 12;
    cell.clipsToBounds = YES;
    cell.backgroundColor = UIColor.whiteColor;
    cell.dataSource = self.dataSource[indexPath.section];
    cell.configurator(^(UILabel * _Nonnull titleLabel) {
        titleLabel.text = [NSString stringWithFormat:@"tableSection-%zd",indexPath.section];
    });
    return cell;
}

// MARK: - Private Methods

- (void)initUI {
    [self.view addSubview:self.dynamicTableView];
    
    [self.dynamicTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Status_And_Navigation_Height());
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

// MARK: - Setter & Getter

- (UITableView *)dynamicTableView {
    if (!_dynamicTableView) {
        _dynamicTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _dynamicTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:250/255.0 alpha:1];
        _dynamicTableView.showsHorizontalScrollIndicator = NO;
        _dynamicTableView.showsVerticalScrollIndicator = NO;
        _dynamicTableView.estimatedRowHeight = 40;
        _dynamicTableView.estimatedSectionHeaderHeight = 0;
        _dynamicTableView.estimatedSectionFooterHeight = 0;
        if (@available (iOS 11, *)) {
            _dynamicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        if (@available (iOS 15, *)) {
            _dynamicTableView.sectionHeaderTopPadding = 0;
        }
        _dynamicTableView.delegate = self;
        _dynamicTableView.dataSource = self;
        
        [_dynamicTableView registerClass:YHDynamicTableViewCellT.class forCellReuseIdentifier:NSStringFromClass(YHDynamicTableViewCellT.class)];
    }
    return _dynamicTableView;
}

- (NSArray<NSArray<NSString *> *> *)dataSource {
    if (!_dataSource) {
        NSMutableArray <NSArray<NSString *> *> *dataSourceM = @[].mutableCopy;
        for (int i = 1; i < 8; i++) {
            NSMutableArray<NSString *> *sectionItems = @[].mutableCopy;
            NSString *str = @"UITableViewCell嵌套UITableView";
            for (int index = 0; index < i; index++) {
                @autoreleasepool {
                    [sectionItems addObject:str];
                }
            }
            [dataSourceM addObject:sectionItems.copy];
        }
        _dataSource = dataSourceM.copy;
    }
    return _dataSource;
}

@end
