//
//  ViewController.m
//  JBPerformanceLogger
//
//  Created by Josip Bernat on 2/5/15.
//  Copyright (c) 2015 Josip Bernat. All rights reserved.
//

#import "ViewController.h"
#import "JBPerformanceLogger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Selectors

- (IBAction)onStart:(id)sender {

    [JBPerformanceLogger start];
}

- (IBAction)onStop:(id)sender {

    [JBPerformanceLogger stop];
}

- (IBAction)onPosition:(id)sender {

    UIButton *button = (UIButton *)sender;
    
    if (button.tag == 10) {
        
        // Top
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionTop];
    }
    else if (button.tag == 11) {
    
        // Top Left
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionTop | JBPerformanceLoggerPositionLeft];
    }
    else if (button.tag == 12) {
    
        // Top right
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionTop | JBPerformanceLoggerPositionRight];
    }
    else if (button.tag == 13) {
    
        // Left
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionLeft];
    }
    else if (button.tag == 14) {
    
        // Right
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionRight];
    }
    else if (button.tag == 15) {
    
        // Bottom
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionBottom];
    }
    else if (button.tag == 16) {
    
        // Bottom left
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionBottom | JBPerformanceLoggerPositionLeft];
    }
    else if (button.tag == 17) {
    
        // Bottom right
        [JBPerformanceLogger setPosition:JBPerformanceLoggerPositionBottom | JBPerformanceLoggerPositionRight];
    }
}

@end
