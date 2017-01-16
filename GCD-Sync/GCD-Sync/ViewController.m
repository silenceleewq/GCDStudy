//
//  ViewController.m
//  GCD-Sync
//
//  Created by lirenqiang on 2016/12/30.
//  Copyright © 2016年 Ninja. All rights reserved.
//
// This project to explain sync in serial queue

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches Began");
    [self testSync];
    
}
//
- (void)testSync
{
    NSLog(@"tet Sync");
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.example.gcd.MySerialDispatchQueue", NULL);
    //在串行队列中加入了一个异步任务
    dispatch_sync(queue, ^{
        NSLog(@"1");
        //在串行队列中加入了一个同步任务.
       dispatch_sync(queue, ^{
           NSLog(@"Hello");
       });
        NSLog(@"2"); // 42
    });
    NSLog(@"dispatch_sync finished");
}

//- (void)testSync
//{
//    NSLog(@"tet Sync");
//    //创建一个串行队列
//    dispatch_queue_t queue = dispatch_queue_create("com.example.gcd.MySerialDispatchQueue", NULL);
//    
//    //在串行队列中加入了一个同步任务.
//    dispatch_sync(queue, ^{
//        NSLog(@"Hello");
//    });
//    
//    NSLog(@"dispatch_sync finished");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
