//
//  BAPropertyName.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/16.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! 索引 */
#define kBALocalizedIndexArrayKey @"kBALocalizedIndexArrayKey"
/*! 排序后的分组，可以为 model */
#define kBALocalizedGroupArrayKey @"kBALocalizedGroupArrayKey"

@interface BAKit_LocalizedIndexedCollation : NSObject

/**
 对数组排序
 
 @param dataArray      需要排序的数组
 @param localizedNameSEL 数组中对象需要排序的属性
 
 @return 排序后的索引及 groupArray 字典形式 kBAPropertyIndexAryKey kBAPropertyGroupAryKey
 */
+ (NSDictionary *)ba_localizedWithDataArray:(NSMutableArray *)dataArray
                           localizedNameSEL:(SEL)localizedNameSEL;

@end
