//
//  NSObject+Parser.h
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#warning 使用 所以对象的属性是 指定数组（指定数组对象类型，需设置className属性）或对象（自定义对象）必须先初始化

#import <Foundation/Foundation.h>

@interface NSObject (Parser)

-(NSDictionary *)toDictionary;

/**
 *  将字典转化成对象
 *
 *  @param clss 对象类型
 *
 *  @return 对象或对象数组
 */
-(id)parserWithClass:(Class)clss;

@end

@interface NSArray (ObjectType)

//指定数组对象类型
@property (nonatomic, copy) NSString *className;

@end