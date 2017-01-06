//
//  ViewController.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+BAColorChange.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.view.backgroundColor = [UIColor colorWithHexString:[self ba_randomColor]];
}

#pragma mark - 随机颜色（十六进制）
- (NSString *)ba_randomColor
{
    NSString *colorString = @"";
    NSArray *colorArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"a", @"b", @"c", @"d", @"e", @"f"];
    
    for (NSInteger i= 0; i < 6; i++)
    {
        int r = arc4random()%colorArray.count;
        NSString *string = colorArray[r];
        colorString = [NSString stringWithFormat:@"%@%@", colorString, string];
        NSLog(@"随机颜色为3：%@", colorString);
    }
    NSLog(@"随机颜色为：%@", colorString);
    return colorString;
}


@end
