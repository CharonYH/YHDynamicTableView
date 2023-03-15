//
//  YHDynamicTableViewCellHeightViewController.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicTableViewCellHeightViewController.h"
#import "YHDynamicHeightFittingTableViewCell.h"
#import "YHDynamicTableViewDefine.h"
#import <Masonry/Masonry.h>

@interface YHDynamicTableViewCellHeightViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <NSString *> *dataSource;

@end

@implementation YHDynamicTableViewCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHDynamicHeightFittingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(YHDynamicHeightFittingTableViewCell.class) forIndexPath:indexPath];
    cell.configurator(^(UILabel * _Nonnull titleLabel, UIView * _Nonnull colorView) {
        titleLabel.text = self.dataSource[indexPath.row];
        colorView.backgroundColor = YHRandomColor;
    });
    cell.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:250/255.0 alpha:1];
    return cell;
}

// MARK: - Private Methods

- (void)initUI {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Status_And_Navigation_Height());
        make.left.right.bottom.mas_equalTo(0);
    }];
}

// MARK: - Setter & Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 10;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if (@available (iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        if (@available (iOS 15, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:YHDynamicHeightFittingTableViewCell.class forCellReuseIdentifier:NSStringFromClass(YHDynamicHeightFittingTableViewCell.class)];
    }
    return _tableView;
}

- (NSMutableArray<NSString *> *)dataSource {
    if (!_dataSource) {
        NSMutableArray <NSString *> *dataSourceM = @[].mutableCopy;
        for (int i = 1; i < 6; i++) {
            @autoreleasepool {
                NSString *str = @"UITableViewCell自适应高度";
                for (int index = 0; index < i; index++) {
                    str = [str stringByAppendingString:str];
                }
                [dataSourceM addObject:str];
            }
        }
        _dataSource = dataSourceM.copy;
    }
    return _dataSource;
}

@end
