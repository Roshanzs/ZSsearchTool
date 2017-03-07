//
//  MainChooesModel.h
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainChooesModel : NSObject
@property(nonatomic,strong)NSString *curPage;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,strong)NSArray *ctgIds;
@property(nonatomic,strong)NSString *ctgTitles;
@property(nonatomic,strong)NSString *menuId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *thumbnail;
@property(nonatomic,strong)NSDictionary *recipe;

@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *ingredients;
@property(nonatomic,strong)NSArray *method;
@property(nonatomic,strong)NSString *title;

+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
