//
//  DemoVC3.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/16.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC3.h"


static NSString * const cellID = @"DemoVC3Cell";

@interface DemoVC3 ()

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
}

#pragma mark - QMUITableView Delegate & DataSource

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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QMUITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell)
    {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"boai";
    UIImage *img = [UIImage ba_imageToRoundImageWithImage:UIImageMake(@"icon1.jpg")];
    cell.imageView.image = [UIImage ba_imageToChangeCellNormalImageViewSizeWithCell:cell image:img imageSize:CGSizeMake(40, 40)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



@end
