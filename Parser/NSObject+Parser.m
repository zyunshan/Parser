//
//  NSObject+Parser.m
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#import "NSObject+Parser.h"
#import <objc/runtime.h>

@implementation NSObject (Parser)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (void)setNilValueForKey:(NSString *)key{
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

-(NSArray *)objectPropertyList{
    if (self.superclass == nil) {//当前类是NSObject 也就是基类
        return @[];
    }
    //获取属性列表
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (const objc_property_t *p=properties; p < properties+outCount; p++) {
        objc_property_t property = *p;
        const char *name = property_getName(property);
        [data addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    
    //获取父类属性列表
    if (![self.superclass conformsToProtocol:@protocol(NSCoding)] && self.superclass) {
        id model = [[self.superclass alloc]init];
        [data addObjectsFromArray:[model objectPropertyList]];
    }
    return data;
}

-(NSDictionary *)toDictionary{
    NSArray *array = [self objectPropertyList];
    if (!array) {
        return @{};
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (NSString *property in array) {
        if (![self valueForKey:property]) {
            [dic setObject:@"" forKey:property];
        }else{
            if ([[self valueForKey:property]conformsToProtocol:@protocol(NSCoding) ]) {
                [dic setObject:[self valueForKey:property] forKey:property];
            }else{
                [dic setObject:[[self valueForKey:property] toDictionary] forKey:property];
            }
        }
    }
    return dic;
}

-(id)parserWithClass:(Class)clss{
    
    id model = [[clss alloc]init];
    
    if ([self isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:[(NSArray *)self count]];
        for (NSDictionary *dic in (NSArray *)self) {
            [array addObject:[dic parserWithClass:clss]];
        }
        return array;
    }
    if ([self isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in [(NSDictionary *)self allKeys]) {
            id value = [model valueForKey:key];
            if (value && ![value isKindOfClass:[NSNumber class]]) {
                if ([value isKindOfClass:[NSArray class]]) {
                    NSString * className = [(NSArray *)value className];
                    if (className == nil) {
                        [model setValue:[(NSDictionary *)self objectForKey:key] forKey:key];
                    }else{
                        Class subClss = NSClassFromString(className);
                        [model setValue:[[(NSDictionary *)self objectForKey:key] parserWithClass:subClss] forKey:key];
                    }
                }else{
                    [model setValue:[[(NSDictionary *)self objectForKey:key] parserWithClass:[value class]] forKey:key];
                }
            }else{
                [model setValue:[(NSDictionary *)self objectForKey:key] forKey:key];
            }
        }
        return model;
    }
    return nil;
}
@end

@implementation NSArray (ObjectType)

-(NSString *)className{
    return objc_getAssociatedObject(self, "ObjectType");
}

- (void)setClassName:(NSString *)className{
    objc_setAssociatedObject(self, "ObjectType", className, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end