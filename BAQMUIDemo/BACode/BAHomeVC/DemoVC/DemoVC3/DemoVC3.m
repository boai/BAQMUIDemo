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

#define tableViewEdgeInsets UIEdgeInsetsMake(0, 15, 0, 0)

@interface DemoVC3 ()<QMUISearchControllerDelegate>

@property (nonatomic, strong) NSMutableArray <DemoVC3_model *>*dataArray;

@property (nonatomic, strong) NSMutableArray <DemoVC3_model *>*searchResultsKeywordsArray;

/*! 索引 */
@property (nonatomic, strong) NSMutableArray <NSString *>*indexArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;

/*! 设置每个section下的cell内容 */
//@property (nonatomic, strong) NSMutableArray <DemoVC3_model *>*letterResultArr;

@property (nonatomic, strong) QMUISearchController *mySearchController;

@end

@implementation DemoVC3

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setupUI
{
    self.mySearchController = [[QMUISearchController alloc] initWithContentsViewController:self];
    self.mySearchController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = self.mySearchController.searchBar;
    
    [self getSectionData];
}

- (void)getSectionData
{
    NSDictionary *dict = [BAKit_LocalizedIndexedCollation ba_localizedWithDataArray:self.dataArray localizedNameSEL:@selector(userName)];
    self.indexArray   = dict[kBALocalizedIndexArrayKey];
    self.sectionArray = dict[kBALocalizedGroupArrayKey];
    
    NSMutableArray *tempModel = [[NSMutableArray alloc] init];
    NSArray *dicts = @[@{@"userName" : @"新的朋友",
                         @"userImageUrl" : @"plugins_FriendNotify"},
                       @{@"userName" : @"群聊",
                         @"userImageUrl" : @"add_friend_icon_addgroup"},
                       @{@"userName" : @"标签",
                         @"userImageUrl" : @"Contact_icon_ContactTag"},
                       @{@"userName" : @"公众号",
                         @"userImageUrl" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts)
    {
        DemoVC3_model *model = [DemoVC3_model new];
        model.userName = dict[@"userName"];
        model.userImageUrl = dict[@"userImageUrl"];
        [tempModel addObject:model];
    }
    
    [self.sectionArray insertObject:tempModel atIndex:0];
    [self.indexArray insertObject:@"" atIndex:0];
}

#pragma mark - QMUITableView Delegate & DataSource
//- (instancetype)initWithStyle:(UITableViewStyle)style
//{
//    if (self = [super initWithStyle:style])
//    {
//        
//    }
//    return self;
//}

- (BOOL)shouldShowSearchBarInTableView:(QMUITableView *)tableView
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return self.indexArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [self.sectionArray[section] count];
    }
    return self.searchResultsKeywordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView  withReuseIdentifier:cellID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    DemoVC3_model *model = nil;
    if (tableView == self.tableView)
    {
        model = self.sectionArray[section][row];
        cell.textLabel.text = model.userName;
    }
    else
    {
        model = self.searchResultsKeywordsArray[row];

        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.userName attributes:@{NSForegroundColorAttributeName:UIColorBlack}];
        
        NSRange range = [model.userName rangeOfString:self.mySearchController.searchBar.text];
        if (range.location != NSNotFound)
        {
            [attributedString addAttributes:@{NSForegroundColorAttributeName:UIColorBlue} range:range];
        }
        cell.textLabel.attributedText = attributedString;
    }
    
    cell.imageView.image = [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:UIImageMake(model.userImageUrl) imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    cell.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.textLabelEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;

    DemoVC3_model *model = nil;
    if (tableView == self.tableView)
    {
        model = self.sectionArray[section][row];
    }
    else
    {
        model = self.searchResultsKeywordsArray[row];
    }
    [self ba_showAlertWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return self.indexArray[section];
    }
    return nil;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
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

#pragma mark - custom Method
- (void)ba_showAlertWithModel:(DemoVC3_model *)model
{
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"博爱温馨提示" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    NSString *message = [NSString stringWithFormat:@"你点击了 %@ ！", model.userName];
    NSString *keyWord = model.userName;
    
    /*! 关键字添加效果 */
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:message];
    
    /*! 获取关键字位置 */
    NSRange range = [message rangeOfString:keyWord];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@2.0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor blueColor],NSStrokeWidthAttributeName:@2.0,NSVerticalGlyphFormAttributeName:@(0)};
    
    /*! 设置关键字属性 */
    [attributedMessage ba_changeAttributeDict:dic range:range];
    
    [UIAlertController ba_alertControllerShowAlertInViewController:self withTitle:@"博爱温馨提示" mutableAttributedTitle:attributedTitle message:@"" mutableAttributedMessage:attributedMessage buttonTitlesArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[UIColorGreen, UIColorRed] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            if (buttonIndex == 0)
            {
                NSLog(@"你点击了取消按钮！");
            }
            else if (buttonIndex == 1)
            {
                NSLog(@"你点击了确定按钮！");
            }
            return;
    }];
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
        
        NSArray *iconImageNamesArray = @[@"0.jpg",
                                         @"1.jpg",
                                         @"2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         @"5.jpg",
                                         @"6.jpg",
                                         @"7.jpg",
                                         ];
        NSArray *namesArray = @[@"博爱",
                                @"boai",
                                @"小明",
                                @"陆晓峰",
                                @"石少庸是小明的老师",
                                @"石少庸",
                                @"Alix",
                                @"Tom",
                                @"Lucy",
                                @"123",
                                @"cydn",
                                @"mami",
                                @"888",
                                @"zhangSan",
                                @"王二",
                                @"微信",
                                @"张小龙"];

        NSMutableArray *iconArray = [NSMutableArray array];
        for (NSInteger i = 0; i < namesArray.count; i ++)
        {
            if (iconImageNamesArray.count < namesArray.count)
            {
                for (NSInteger j = 0; j < iconImageNamesArray.count; j ++)
                {
                    [iconArray addObject:iconImageNamesArray[ba_randomNumber(iconImageNamesArray.count)]];
                }
            }
            DemoVC3_model *model = [[DemoVC3_model alloc] init];
            model.userImageUrl = iconArray[i];
            model.userName = namesArray[i];
            
            [self.dataArray addObject:model];
        }
	}
	return _dataArray;
}

- (NSMutableArray <NSString *> *)indexArray
{
	if(_indexArray == nil)
    {
		_indexArray = [[NSMutableArray <NSString *> alloc] init];
	}
	return _indexArray;
}

- (NSMutableArray *)sectionArray
{
	if(_sectionArray == nil)
    {
		_sectionArray = [[NSMutableArray alloc] init];
	}
	return _sectionArray;
}

@end
