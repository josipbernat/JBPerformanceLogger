//
//  JBPerformanceLogger.m
//  JBPerformanceLogger
//
//  Created by Josip Bernat on 2/5/15.
//  Copyright (c) 2015 Josip Bernat. All rights reserved.
//

#import "JBPerformanceLogger.h"
#import "PureLayout.h"

@interface JBPerformanceLogger ()

@property (strong, nonatomic) UILabel *displayLabel;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (readwrite, nonatomic) NSTimeInterval previousTimestamp;
@property (readwrite, nonatomic) CGFloat frameCount;
@property (readwrite, nonatomic) JBPerformanceLoggerPosition position;
@property (readwrite, nonatomic) CGFloat positionOffset;

@end

@implementation JBPerformanceLogger

#pragma mark - Shared Instance

+ (instancetype)sharedLogger {
    
    static JBPerformanceLogger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - Memory Management

- (void)dealloc {
    
    [_displayLink invalidate];
    _displayLink = nil;
}

#pragma mark - Initialization

- (instancetype)init {
    
    if (self = [super init]) {
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _displayLink.paused = YES;
        
        _previousTimestamp = 0.0f;
        _frameCount = 0.0f;
        
        _position = JBPerformanceLoggerPositionBottom | JBPerformanceLoggerPositionLeft;
        _positionOffset = 8.0F;
        
        [self __setupDisplayLabel];
    }
    return self;
}

- (void)__setupDisplayLabel {
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self __setupDisplayLabel];
        });
        return;
    }
    
    _displayLabel = [[UILabel alloc] initForAutoLayout];
    _displayLabel.textColor = [UIColor redColor];
    _displayLabel.backgroundColor = [UIColor clearColor];
    _displayLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    _displayLabel.hidden = YES;
    
    [self __updateDisplayLabelPositon];
}

- (void)__updateDisplayLabelPositon {
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self __updateDisplayLabelPositon];
        });
        return;
    }
    
    [_displayLabel removeFromSuperview];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_displayLabel];
    
    // Set dimension
    [_displayLabel autoSetDimension:ALDimensionWidth toSize:0.0f relation:NSLayoutRelationGreaterThanOrEqual];
    [_displayLabel autoSetDimension:ALDimensionHeight toSize:0.0f relation:NSLayoutRelationGreaterThanOrEqual];
    
    BOOL didPinToEdges = NO;
    if ((_position & JBPerformanceLoggerPositionLeft) == JBPerformanceLoggerPositionLeft) {
        
        didPinToEdges = YES;
        
        // Pin to left
        [_displayLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:window withOffset:_positionOffset];
    }
    else if ((_position & JBPerformanceLoggerPositionRight) == JBPerformanceLoggerPositionRight) {
        
        didPinToEdges = YES;
        
        // Pin to right
        [_displayLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:window withOffset:-_positionOffset];
    }
    
    
    if ((_position & JBPerformanceLoggerPositionBottom) == JBPerformanceLoggerPositionBottom) {
        
        // Pin to bottom
        [_displayLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:window withOffset:-_positionOffset];
        
        if ((_position & JBPerformanceLoggerPositionTop) == JBPerformanceLoggerPositionTop) {
            NSAssert(NO, @"Invalid position. Cannot place it at top and bottom at same time!");
        }
        else if (!didPinToEdges) {
            // Pin to center
            [_displayLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        }
    }
    else if ((_position & JBPerformanceLoggerPositionTop) == JBPerformanceLoggerPositionTop) {
        
        // Pin to bottom
        [_displayLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:window withOffset:_positionOffset];
        
        if ((_position & JBPerformanceLoggerPositionBottom) == JBPerformanceLoggerPositionBottom) {
            NSAssert(NO, @"Invalid position. Cannot place it at top and bottom at same time!");
        }
        else if (!didPinToEdges) {
            // Pin to center
            [_displayLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        }
    }
    else {
        
        // Pin to center
        [_displayLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    }
}

#pragma mark - Display Link Selector

- (void)onDisplayLink:(CADisplayLink *)link {
    
    //    NSLog(@"FPS: %.2f", 1.f / link.duration);
    
    CFTimeInterval now = CFAbsoluteTimeGetCurrent();
    CFTimeInterval elapsed = now - self.previousTimestamp;
    self.frameCount++;
    
    //    NSLog(@"%f, %f", link.timestamp, link.duration);
    
    if (elapsed > 1 / 60.0f) {
        
        CGFloat fps = self.frameCount / elapsed;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _displayLabel.text = [NSString stringWithFormat:@"%.2f FPS", fps];
        });
        
        _previousTimestamp = now;
        _frameCount = 0;
    }
}

#pragma mark - Starting

+ (void)start {
    
#ifdef DEBUG
    
    JBPerformanceLogger *instance = [self sharedLogger];
    if (!instance.displayLink.isPaused) {
        return;
    }
    
    instance.displayLink.paused = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        instance.displayLabel.hidden = NO;
    });
#endif
}

#pragma mark - Stopping

+ (void)stop {
    
#ifdef DEBUG
    
    JBPerformanceLogger *instance = [self sharedLogger];
    instance.displayLink.paused = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        instance.displayLabel.hidden = YES;
    });
#endif
}

#pragma mark - Interface

+ (void)setPosition:(JBPerformanceLoggerPosition)position {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        JBPerformanceLogger *instance = [self sharedLogger];
        instance.position = position;
        [instance __updateDisplayLabelPositon];
    });
}

+ (void)setPositionOffset:(CGFloat)offset {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        JBPerformanceLogger *instance = [self sharedLogger];
        instance.positionOffset = (offset < 0.0f ? offset * -1.0f : offset);
        [instance __updateDisplayLabelPositon];
    });
}

+ (void)setTextColor:(UIColor *)textColor {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        JBPerformanceLogger *instance = [self sharedLogger];
        instance.displayLabel.textColor = textColor;
    });
}

@end
