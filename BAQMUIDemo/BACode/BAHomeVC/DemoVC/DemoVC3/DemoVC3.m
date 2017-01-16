//
//  DemoVC3.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/16.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC3.h"
#import "DemoVC3_model.h"

static NSString * const cellID = @"DemoVC3Cell";

#define cellHeight        50
#define cellImageViewSize cellHeight * 0.8

@interface DemoVC3 ()<QMUISearchControllerDelegate>

@property (nonatomic, strong) NSMutableArray <DemoVC3_model *>*dataArray;

@property (nonatomic, strong) NSMutableArray <DemoVC3_model *>*searchResultsKeywordsArray;

@property (nonatomic, strong) QMUISearchController *mySearchController;

@end

@implementation DemoVC3

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setupUI
{
//    self.tableView.backgroundColor = UIColorWhite;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.mySearchController = [[QMUISearchController alloc] initWithContentsViewController:self];
    self.mySearchController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = self.mySearchController.searchBar;

}

#pragma mark - QMUITableView Delegate & DataSource
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        
    }
    return self;
}


- (BOOL)shouldShowSearchBarInTableView:(QMUITableView *)tableView
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return self.dataArray.count;
    }
    return self.searchResultsKeywordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QMUITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DemoVC3_model *model = nil;
    if (tableView == self.tableView)
    {
        model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.userName;
    }
    else
    {
        model = self.searchResultsKeywordsArray[indexPath.row];

        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.userName attributes:@{NSForegroundColorAttributeName:UIColorBlack}];
        
        NSRange range = [model.userName rangeOfString:self.mySearchController.searchBar.text];
        if (range.location != NSNotFound)
        {
            [attributedString addAttributes:@{NSForegroundColorAttributeName:UIColorBlue} range:range];
        }
        cell.textLabel.attributedText = attributedString;
    }
    
    UIImage *img = [UIImage ba_imageToRoundImageWithImage:UIImageMake(model.userImageUrl)];
    cell.imageView.image = [UIImage ba_imageToChangeCellNormalImageViewSizeWithCell:cell image:img imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

#pragma mark - QMUISearchControllerDelegate
- (void)searchController:(QMUISearchController *)searchController updateResultsForSearchString:(NSString *)searchString
{
    [self.searchResultsKeywordsArray removeAllObjects];
    
    for (DemoVC3_model *model in self.dataArray)
    {
        if ([model.userName qmui_includesString:searchString])
        {
            [self.searchResultsKeywordsArray addObject:model];
        }
    }

    [searchController.tableView reloadData];
    
    if (self.searchResultsKeywordsArray.count == 0)
    {
        [searchController showEmptyViewWithText:@"没有匹配结果！" detailText:nil buttonTitle:nil buttonAction:NULL];
    }
    else
    {
        [searchController hideEmptyView];
    }
}

- (void)willPresentSearchController:(QMUISearchController *)searchController
{
    [QMUIHelper renderStatusBarStyleDark];
}

- (void)willDismissSearchController:(QMUISearchController *)searchController
{
    BOOL oleStatusBarLight = NO;
    if ([self respondsToSelector:@selector(shouldSetStatusBarStyleLight)])
    {
        oleStatusBarLight = [self shouldSetStatusBarStyleLight];
    }
    if (oleStatusBarLight)
    {
        [QMUIHelper renderStatusBarStyleLight];
    }
    else
    {
        [QMUIHelper renderStatusBarStyleDark];
    }
}

#pragma mark - setter / getter
- (NSMutableArray <DemoVC3_model *> *)searchResultsKeywordsArray
{
	if(_searchResultsKeywordsArray == nil)
    {
		_searchResultsKeywordsArray = [[NSMutableArray <DemoVC3_model *> alloc] init];
	}
	return _searchResultsKeywordsArray;
}

- (NSMutableArray <DemoVC3_model *> *)dataArray
{
	if(_dataArray == nil)
    {
		_dataArray = [[NSMutableArray <DemoVC3_model *> alloc] init];
        
        NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                         @"icon1.jpg",
                                         @"icon2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         @"icon2.jpg",
                                         ];
        
        NSArray *namesArray = @[@"博爱",
                                @"boai",
                                @"小明",
                                @"陆晓峰",
                                @"石少庸是小明的老师",
                                @"石少庸"];
        for (NSInteger i = 0; i < 50; i ++)
        {
            DemoVC3_model *model = [[DemoVC3_model alloc] init];
            model.userImageUrl = iconImageNamesArray[ba_randomNumber(6)];
            model.userName = namesArray[ba_randomNumber(6)];

            [self.dataArray addObject:model];
        }
	}
	return _dataArray;
}

@end
