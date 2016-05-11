//
//  People.h
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property (nonatomic, copy) NSString *cellPhone;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *disrict;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, assign) int pcdId;
@end

@interface ResultModel : NSObject

@property (nonatomic, copy) NSString *version;
@property (nonatomic, strong) NSArray <People *> *data;
@property (nonatomic, copy) NSString *other;
@end