//
//  MainInfoModel.h
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainInfoModel : NSObject

+(instancetype)modelWithDict:(NSDictionary *)dict;

@property(nonatomic,strong)NSString *ctgId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *parentId;
@property(nonatomic,strong)NSArray *childs;
@property(nonatomic,strong)NSDictionary *categoryInfo;
@end
