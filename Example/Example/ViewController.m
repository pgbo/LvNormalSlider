//
//  ViewController.m
//  Example
//
//  Created by 彭光波 on 16/3/21.
//  Copyright © 2016年 pgbo. All rights reserved.
//

#import "ViewController.h"
#import <LvNormalSlider/LvNormalSlider.h>

@interface ViewController ()

@property (nonatomic) LvNormalSlider *mSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.mSlider = [[LvNormalSlider alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    self.mSlider.backgroundColor = [UIColor clearColor];
    self.mSlider.handleSize = 12;
    self.mSlider.handleShadowSize = 10;
    [self.view addSubview:self.mSlider];
    
    [self.mSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged:(id)sender
{
    NSLog(@"slider value: %@", @(self.mSlider.value));
}

@end
