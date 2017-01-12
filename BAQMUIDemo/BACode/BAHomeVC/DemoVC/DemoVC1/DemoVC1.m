//
//  DemoVC1.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC1.h"
#import "DemoVC1_model.h"
#import "DemoVC1_cell.h"

@interface DemoVC1 () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) NSMutableArray <DemoVC1_model *>*dataArray;
@property (nonatomic, strong) QMUIOrderedDictionary *dataSourceWithDetailText;

@end

@implementation DemoVC1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    self.view.backgroundColor = UIColorGreen;
}

- (void)setupUI
{
    self.tableView.hidden = NO;
    [self.tableView registerClass:[DemoVC1_cell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    DemoVC1_cell *cell = (DemoVC1_cell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[DemoVC1_cell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.model = self.dataArray[indexPath.row];
//    [cell renderWithNameText:self.dataArray[indexPath.row].userName  contentText:self.dataArray[indexPath.row].content];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";

    return [self.tableView qmui_heightForCellWithIdentifier:cellID cacheByIndexPath:indexPath configuration:^(DemoVC1_cell *cell) {
        
        cell.model = self.dataArray[indexPath.row];
//        [cell renderWithNameText:self.dataArray[indexPath.row].userName  contentText:self.dataArray[indexPath.row].content];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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

- (NSMutableArray<DemoVC1_model *> *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[].mutableCopy;
        NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                         @"icon1.jpg",
                                         @"icon2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         ];
        
        NSArray *namesArray = @[@"博爱",
                                @"小明",
                                @"陆晓峰",
                                @"石少庸是小明的老师",
                                @"石少庸"];
        
        NSArray *textArray = @[@"耳机只要一取出，就可与你的各种设备配合使用。将它们戴入耳中，瞬间便完成连接。对它们讲话时，你的声音格外清晰。全新 AirPods，令简约与技术的融合更胜以往，带来妙处连连。",
                               @"简单轻点一下即可完成设置，然后 AirPods 便自动开启并始终保持连接1。使用也同样轻轻松松，一戴入耳中它们即可感知，一取出就会暂停播放。无论是聆听你的 iPhone、Apple Watch、iPad，还是 Mac 上的内容，使用 AirPods 的体验都同样精彩。",
                               @"与你喜爱的私人助理交谈轻而易举。轻点两下任一边 AirPods 即可激活 Siri，连掏出你的 iPhone 都不需要2。",
                               @"AirPods 的所有创举均得益于 Apple 特别设计的 W1 芯片。它带来十分高效的无线性能，从而提供更佳的连接和更好的音质。W1 芯片对电池续航时间的管理十分出色，一次充电即可让你尽情聆听 5 小时3。如此高性能，集成在如此小巧的设备中，闻所未闻。",
                               @"AirPods 一次充电可聆听 5 小时3，表现出众。再加上充电盒能存储多次额外充电的电量，满足超过 24 小时的续航， AirPods 更能与你时刻相伴4。需要快速充电？只需放入充电盒中 15 分钟即可获得最长可达 3 小时的聆听时间5。要查看电池电量，只需将 AirPods 靠近你的 iPhone，或者问问 Siri 你的 AirPods 还剩多少电量。"
                               ];
        NSArray *timeArray = @[@"2016-03-06",@"2016-03-07",@"2016-03-08",@"2016-03-09",@"2016-03-10"];
        
        for (NSInteger i = 0; i < 100; i ++)
        {
            DemoVC1_model *model = [[DemoVC1_model alloc] init];
            model.userImageUrl = iconImageNamesArray[ba_randomNumber(5)];
            model.userName = namesArray[ba_randomNumber(5)];
            model.content = textArray[ba_randomNumber(5)];
            model.time = timeArray[ba_randomNumber(5)];
            
            [self.dataArray addObject:model];
        }
    }
    return _dataArray;
}



@end

@implementation DemoVC1 (UISubclassingHooks)

- (void)initDataSource
{
    
}

- (void)didSelectCellWithTitle:(NSString *)title
{
    
}

@end
