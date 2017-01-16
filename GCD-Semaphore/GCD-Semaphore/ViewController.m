//
//  ViewController.m
//  GCD-Semaphore
//
//  Created by lirenqiang on 2017/1/4.
//  Copyright © 2017年 Ninja. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //这样容易崩溃.
    for (NSInteger i = 0; i < 10000; ++i) {
        dispatch_async(queue, ^{
            [array addObject:[NSNumber numberWithInteger:i]];
        });
    }
    
    */
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    long result = dispatch_semaphore_wait(semaphore, time);
    if (result == 0) {
        
    } else
    {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
