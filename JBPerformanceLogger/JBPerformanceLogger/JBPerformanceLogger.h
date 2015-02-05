//
//  JBPerformanceLogger.h
//  JBPerformanceLogger
//
//  Created by Josip Bernat on 2/5/15.
//  Copyright (c) 2015 Josip Bernat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, JBPerformanceLoggerPosition) {
    
    JBPerformanceLoggerPositionTop      = 1 << 0,
    JBPerformanceLoggerPositionBottom   = 1 << 1,
    JBPerformanceLoggerPositionLeft     = 1 << 2,
    JBPerformanceLoggerPositionRight    = 1 << 3
};

@interface JBPerformanceLogger : NSObject

#pragma mark - Starting
/**
 *  Starts performance logger and shows label in key window.
 */
+ (void)start;

#pragma mark - Stopping
/**
 *  Stops performance logger and hides label from key window.
 */
+ (void)stop;

#pragma mark - Interface
/**
 *  Sets position of logger label. Default is bottom left.
 *
 *  @param position Position of label.
 */
+ (void)setPosition:(JBPerformanceLoggerPosition)position;

/**
 *  Sets label offset. Default value is 8.0f. Uses absolute of given value.
 *
 *  @param offset Offset in points.
 */
+ (void)setPositionOffset:(CGFloat)offset;

/**
 *  Sets text color of display label. Default value is [UIColor redColor].
 *
 *  @param textColor Desired color.
 */
+ (void)setTextColor:(UIColor *)textColor;

@end
