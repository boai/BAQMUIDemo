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
    
//    NSMutableArray *namesArray = @[].mutableCopy;
//    for (DemoVC3_model *model in self.dataArray)
//    {
//        [namesArray addObject:model.userName];
//    }
    
//    /*! 索引 */
//    self.indexArray = [BAKit_ChineseString ba_chineseStringIndexArray:[namesArray mutableCopy]];
//    /*! 排序后的联系人数组 */
//    self.letterResultArr = [BAKit_ChineseString ba_chineseStringLetterSortArray:namesArray];
    
    [self getSectionData];
}

- (void)getSectionData
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    /*! create a temp sectionArray */
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = @[].mutableCopy;
    
    for (NSInteger index = 0; index < numberOfSections; index++)
    {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    
    /*! insert Persons info into newSectionArray */
    for (DemoVC3_model *model in self.dataArray)
    {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(userName)];
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    /*! sort the person of each section */
    for (NSInteger index = 0; index < numberOfSections; index++)
    {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(userName)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (array.count == 0)
        {
            [temp addObject:array];
        }
        else
        {
            [self.indexArray addObject:[collation sectionTitles][idx]];
        }
    }];
    [newSectionArray removeObjectsInArray:temp];

    NSMutableArray *tempModel = [NSMutableArray new];
    NSArray *dicts = @[@{@"name" : @"新的朋友",
                         @"imageName" : @"plugins_FriendNotify"},
                       @{@"name" : @"群聊",
                         @"imageName" : @"add_friend_icon_addgroup"},
                       @{@"name" : @"标签",
                         @"imageName" : @"Contact_icon_ContactTag"},
                       @{@"name" : @"公众号",
                         @"imageName" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts) {
        DemoVC3_model *model = [DemoVC3_model new];
        model.userName = dict[@"name"];
        model.userImageUrl = dict[@"imageName"];
        [tempModel addObject:model];
    }
    
    [newSectionArray insertObject:tempModel atIndex:0];
    [self.indexArray insertObject:@"" atIndex:0];
    
    self.sectionArray = newSectionArray;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

    DemoVC3_model *model = self.sectionArray[section][row];
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
        
        NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                         @"icon1.jpg",
                                         @"icon2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         @"icon0.jpg",
                                         @"icon1.jpg",
                                         @"icon2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         @"icon0.jpg"
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
                                @"cydn"];
        
//        for (NSInteger i = 0; i < 50; i ++)
//        {
//            DemoVC3_model *model = [[DemoVC3_model alloc] init];
//            model.userImageUrl = iconImageNamesArray[ba_randomNumber(6)];
//            model.userName = namesArray[ba_randomNumber(6)];
//
//            [self.dataArray addObject:model];
//        }
        for (NSInteger i = 0; i < namesArray.count; i ++)
        {
            DemoVC3_model *model = [[DemoVC3_model alloc] init];
            model.userImageUrl = iconImageNamesArray[i];
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
