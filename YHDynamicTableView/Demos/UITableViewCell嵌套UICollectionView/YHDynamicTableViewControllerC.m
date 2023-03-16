//
//  YHDynamicTableViewControllerC.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicTableViewControllerC.h"
#import "YHDynamicTableViewCellC.h"
#import "YHDynamicTableViewDefine.h"
#import <Masonry/Masonry.h>

@interface YHDynamicTableViewControllerC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *dynamicTableView;
@property (nonatomic, strong) NSArray <NSArray <NSNumber *> *> *dataSource;

@end

@implementation YHDynamicTableViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self configButtonBarItems];
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
    YHDynamicTableViewCellC *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(YHDynamicTableViewCellC.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius = 12;
    cell.clipsToBounds = YES;
    cell.dataSource = self.dataSource[indexPath.section];
    cell.configurator(^(UILabel * _Nonnull titleLabel) {
        titleLabel.text = [NSString stringWithFormat:@"tableSection-%zd",indexPath.section];
    });
    return cell;
}

// MARK: - Private Methods

- (void)configButtonBarItems {
    UIBarButtonItem *shuffleItem = [[UIBarButtonItem alloc] initWithTitle:@"随机打乱数据源" style:UIBarButtonItemStyleDone target:self action:@selector(navigationBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItems = @[shuffleItem];
}

- (void)navigationBarButtonItemClick:(UIBarButtonItem *)sender {
    self.dataSource = [self shuffledWithArray:self.dataSource];
    [self.dynamicTableView reloadData];
}

- (NSArray <NSArray <NSNumber *> *> *)shuffledWithArray:(NSArray <NSArray <NSNumber *> *> *)array {
    NSMutableArray *shuffledArray = array.mutableCopy;
    for (NSUInteger i = shuffledArray.count - 1; i > 0; i--) {
        NSUInteger n = arc4random_uniform((uint32_t)i + 1);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return [shuffledArray copy];
}

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
        // 不写也可以
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
        
        [_dynamicTableView registerClass:YHDynamicTableViewCellC.class forCellReuseIdentifier:NSStringFromClass(YHDynamicTableViewCellC.class)];
    }
    return _dynamicTableView;
}

- (NSArray<NSArray<NSNumber *> *> *)dataSource {
    if (!_dataSource) {
        NSMutableArray <NSArray<NSNumber *> *> *dataSourceM = @[].mutableCopy;
        for (int i = 5; i < 20; i++) {
            NSMutableArray<NSNumber *> *sectionItems = @[].mutableCopy;
            for (int index = 0; index < i; index++) {
                [sectionItems addObject:@(index)];
            }
            [dataSourceM addObject:sectionItems.copy];
        }
        _dataSource = dataSourceM.copy;
    }
    return _dataSource;
}

@end
