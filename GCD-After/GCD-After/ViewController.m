//
//  ViewController.m
//  GCD-After
//
//  Created by lirenqiang on 2016/12/27.
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
//    [self test1];
    [self test2];
}

- (void)test2
{
    NSDate *date = [NSDate date];
    NSLog(@"date:%@", date);
    dispatch_time_t time = getDispatchTimeByDate(date);
    NSLog(@"%zd", time);
}

/**
 根据一个NSDate类型返回一个dispatch_time_t类型值
 return a dispatch_time_t var

 @param date NSDate instance

 @return dispatch_time_t
 */
dispatch_time_t getDispatchTimeByDate(NSDate *date)
{
    
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
}

//
- (void)test1
{
    //这个只是在当前时间后0.5秒加入到主队列一个block,然而这个block还是得等到主队列的任务完成后,才去执行,所以有时候,会得到出乎意料的结果.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        NSLog(@"dispatch_after");
    });
    for (NSInteger i = 0; i < 10000; ++i) {
        NSLog(@"%zd", i);
        UIButton *btn = [[UIButton alloc] init];
        [self.view addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
