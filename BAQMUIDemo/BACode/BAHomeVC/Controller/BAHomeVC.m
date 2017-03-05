//
//  BAHomeVC.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAHomeVC.h"
#import "BALaunchADNet.h"
#import "YYModel.h"

@interface BAHomeVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) QMUITableView   *tableView;

@property (nonatomic, strong) NSMutableArray  *titlesArray;
@property (nonatomic, strong) NSMutableArray  *classNamesArray;
@property (nonatomic, strong) NSMutableArray  *contentsArray;

@end

@implementation BAHomeVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.view.backgroundColor = UIColorGreen;
    
}

- (void)setupUI
{
    self.tableView.hidden = NO;
    
    [self creatDatas];
    
    [self test];
}

- (void)test
{
//    [self.view showProgress:"加载中..."];
    [[BALaunchADNet sharedBALaunchADNet] ba_getVideosWithStartIndex:1 completionHandle:^(BAVideoModel *data, NSError *error) {
//        [hide...];
        if (data)
        {
            NSLog(@"dat1:  %@", data.videoHomeSid);
            NSLog(@"dat2:  %@", data.videoSidList);
            NSLog(@"dat3:  %@", data.videoList);
            
            Videolist *list0 = data.videoList[0];
            NSLog(@"dat4:  %@", list0.title);
            NSLog(@"dat5:  %@", list0.mp4_url);

        }
        
    }];
    
}


- (void)creatDatas
{
    [self addCell:@"1、QMUITableView 用法" content:@"QMUITableView " class:@"DemoVC1"];
    [self addCell:@"2、QMUITips 用法" content:@"QMUITips " class:@"DemoVC2"];

}

- (void)addCell:(NSString *)title
        content:(NSString *)content
          class:(NSString *)className
{
    [self.titlesArray addObject:title];
    [self.contentsArray  addObject:content];
    [self.classNamesArray addObject:className];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.textLabel.font = UIFontMake(15);
    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableViewCellNormalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.classNamesArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class)
    {
        UIViewController *vc = class.new;
        vc.title = self.titlesArray[indexPath.row];
        
        /*! 转场动画 */
        [self ba_animationWithBATransitionType:ba_randomNumber(12) animationView:self.navigationController.view];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}

#pragma mark - setter / getter
- (QMUITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[QMUITableView alloc] init];
        
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)titlesArray
{
    if (!_titlesArray)
    {
        _titlesArray = @[].mutableCopy;
    }
    return _titlesArray;
}

- (NSMutableArray *)classNamesArray
{
    if (!_classNamesArray)
    {
        _classNamesArray = @[].mutableCopy;
    }
    return _classNamesArray;
}

- (NSMutableArray *)contentsArray
{
    if (!_contentsArray)
    {
        _contentsArray = @[].mutableCopy;
    }
    return _contentsArray;
}

@end
