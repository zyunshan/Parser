
//
//  People.m
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#import "People.h"
#import "NSObject+Parser.h"

@implementation People

@end


@implementation ResultModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _data = [NSArray array];
        _data.className = @"People";
    }
    return self;
}
@end