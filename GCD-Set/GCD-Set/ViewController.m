//
//  ViewController.m
//  GCD-Set
//
//  Created by lirenqiang on 2016/12/22.
//  Copyright © 2016年 Ninja. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    [self testTargetQueue];
}

- (void)testTargetQueue {
    dispatch_queue_t targetQueue = dispatch_queue_create("test.target.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("test.3", DISPATCH_QUEUE_SERIAL);
    
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_set_target_queue(queue3, targetQueue);
    
    dispatch_async(queue1, ^{
        NSLog(@"1 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"1 out");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"2 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"2 out");
    });
    
    dispatch_async(queue3, ^{
        NSLog(@"3 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"3 out");
    });
    
    
}

- (void)testTargetQueue2 {
    //创建一个串行队列queue1
    dispatch_queue_t queue1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);
    
    //使用dispatch_set_target_queue()实现队列的动态调度管理
    dispatch_set_target_queue(queue1, queue2);
    
    dispatch_async(queue1, ^{
        for (NSInteger i = 0; i < 10; ++i) {
            NSLog(@"queue1: %@, %ld", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:0.5];
            if (i == 5) {
                dispatch_suspend(queue1);
            }
        }
    });
    
//    dispatch_async(queue1, ^{
//        for (NSInteger i = 0; i < 100; ++i) {
//            NSLog(@"queue1: %@, %ld", [NSThread currentThread], i);
//        }
//    });
    
    dispatch_async(queue2, ^{
        for (NSInteger i = 0; i < 100; ++i) {
            NSLog(@"queue2: %@, %ld", [NSThread currentThread], i);
        }
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
