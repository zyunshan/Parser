//
//  ViewController.m
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
#import "NSObject+Parser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"File" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    ResultModel *model = [dict parserWithClass:[ResultModel class]];
    
    NSLog(@"%@", [model description]);
    
    NSLog(@"%@", [model version]);
    NSLog(@"%@", [[model.data objectAtIndex:0] cellPhone]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
