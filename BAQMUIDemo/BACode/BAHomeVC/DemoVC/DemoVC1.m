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
//    cell.model = self.dataArray[indexPath.row];
    [cell renderWithNameText:self.dataArray[indexPath.row].userName  contentText:self.dataArray[indexPath.row].content];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";

    return [self.tableView qmui_heightForCellWithIdentifier:cellID cacheByIndexPath:indexPath configuration:^(id cell) {
        
//        cell.model = self.dataArray[indexPath.row];
        [cell renderWithNameText:self.dataArray[indexPath.row].userName  contentText:self.dataArray[indexPath.row].content];
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
                                @"张三",
                                @"我是小明的老师",
                                @"小三"];
        
        NSArray *textArray = @[@"欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，让它从里到外焕然一新。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。",
                               @"iPhone SE 采用了备受欢迎的设计，并让它更加出色。铝金属表面经过喷砂工艺处理，打造出绸缎般的质感，让这款小巧、轻便的手机握持时手感非常舒适。绚丽的 4 英寸1 Retina 显示屏让图像显得生动、锐利。倒角边缘经过哑光处理，不锈钢 Apple 标志的颜色也与机身相配，整个外观显得格外精致。",
                               @"iPhone SE 的核心是 A9 芯片，它与 iPhone 6s 采用了相同的先进芯片。",
                               @"高能效的M9 运动协处理器M9 运动协处理器直接嵌入在 A9 芯片上，并与加速感应器、指南针及三轴陀螺仪相连，具备一系列追踪健身活动的功能，比如记录你的步数和距离。而且，有了它，你不必拿起 iPhone，只需说一声 “嘿 Siri” 就能轻松激活 Siri。",
                               @"Live Photos 可捕捉声音和动作，让你的影像生动鲜活。只需在你的 1200 万像素照片上按住任意位置，就能重温照片拍摄前后的时刻，让你的照片变成鲜活的记忆。"
                               ];
        NSArray *timeArray = @[@"2016-03-06",@"2016-03-07",@"2016-03-08",@"2016-03-09",@"2016-03-10"];

        
        for (NSInteger i = 0; i < 20; i ++)
        {
            int iconRandomIndex = arc4random_uniform(5);
            int nameRandomIndex = arc4random_uniform(5);
            int contentRandomIndex = arc4random_uniform(5);
            int timeRandomIndex = arc4random_uniform(5);
            
            DemoVC1_model *model = [[DemoVC1_model alloc] init];
            model.userImageUrl = iconImageNamesArray[iconRandomIndex];
            model.userName = namesArray[nameRandomIndex];
            model.content = textArray[contentRandomIndex];
            model.time = timeArray[timeRandomIndex];
            
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
