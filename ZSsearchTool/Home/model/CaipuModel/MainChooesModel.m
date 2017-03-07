//
//  MainChooesModel.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "MainChooesModel.h"

@implementation MainChooesModel

+(instancetype)modelWithDict:(NSDictionary *)dict{
    MainChooesModel *model = [[MainChooesModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
