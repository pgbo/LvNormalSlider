//
//  LvNormalSlider.m
//  EnjoySelf
//
//  Created by guangbo on 14-10-16.
//  Copyright (c) 2014年 光波 彭. All rights reserved.
//

#import "LvNormalSlider.h"
#import "LvNormalSliderConfigurations.h"

@interface LvNormalSlider ()
/**
 *  判断某个点是否在轨迹上
 *
 *  @param point 要判断的点
 *
 *  @return 是否在轨迹上
 */
- (BOOL)isPointOnSlider:(CGPoint)point;
@end

@implementation LvNormalSlider

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupNormalSlider];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupNormalSlider];
    }
    return self;
}

- (void)setupNormalSlider
{
    self.backgroundColor = [UIColor clearColor];
    
    _handleSize = LvHandleDefaultWidth;
    _handleShadowSize = LvHandleShadowDefaultWidth;
    _sliderLineWidth = LvNormalSliderLineDefaultWidth;
    _sliderBackgroundColor = LvDefaultSliderBackgroundColor;
    _trackColor = LvDefaultTrackColor;
}

- (void)setTrackColor:(UIColor *)trackColor
{
    if ([trackColor isEqual:self.trackColor]) {
        return;
    }
    _trackColor = trackColor;
    [self setNeedsDisplay];
}

- (void)setSliderBackgroundColor:(UIColor *)sliderBackgroundColor
{
    if ([sliderBackgroundColor isEqual:self.sliderBackgroundColor]) {
        return;
    }
    _sliderBackgroundColor = sliderBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setValue:(CGFloat)value
{
    CGFloat val = value;
    if (val < 0)
        val = 0;
    else if (val > 1)
        val = 1;
    _value = val;
    [self setNeedsDisplay];
}

- (void)setSliderLineWidth:(CGFloat)sliderLineWidth
{
    if (_sliderLineWidth == sliderLineWidth) {
        return;
    }
    _sliderLineWidth = sliderLineWidth;
    [self setNeedsDisplay];
}

- (void)setHandleSize:(CGFloat)handleSize
{
    if (_handleSize == handleSize)
        return;
    _handleSize = handleSize;
    [self setNeedsDisplay];
}

- (void)setHandleShadowSize:(CGFloat)handleShadowSize
{
    if (_handleShadowSize == handleShadowSize)
        return;
    _handleShadowSize = handleShadowSize;
    [self setNeedsDisplay];
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (BOOL)isPointOnSlider:(CGPoint)point
{
    CGRect sliderFrame = [self frameForSliderLineWithParentSize:self.bounds.size];
    return CGRectContainsPoint(sliderFrame, point);
}

#pragma mark - UIControl Override -

/** Tracking is started **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    //We need to track continuously
    return YES;
}

/** Track continuos touch event (like drag) **/
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    //Get touch location
    CGPoint lastPoint = [touch locationInView:self];
    
    // Check touch location is on slider
    if ([self isPointOnSlider:lastPoint]) {
        
        //Use the location to design the Handle
        [self movehandle:lastPoint];
        
        //Control value has changed, let's notify that
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    return YES;
}

/** Track is finished **/
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    
}

- (void)movehandle:(CGPoint)point
{
    CGRect sliderFrame = [self frameForSliderLineWithParentSize:self.bounds.size];
    CGFloat val = (point.x - sliderFrame.origin.x)/sliderFrame.size.width;
    [self setValue:val];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //Define line width
    CGContextSetLineWidth(ctx, self.sliderLineWidth);
    
    /** Draw The Slider Background Line **/
    
    // Define line cap
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //Create the path
    CGRect sliderFrame = [self frameForSliderLineWithParentSize:rect.size];
    CGPoint startPoint = CGPointMake(sliderFrame.origin.x, sliderFrame.size.height/2 + sliderFrame.origin.y);
    CGPoint endPoint = CGPointMake(startPoint.x + sliderFrame.size.width, startPoint.y);
    
    //Set the stroke color
    [self.sliderBackgroundColor setStroke];
    
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    
    //draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    /**
     *  Draw track line
     */
    CGPoint trackPoint = CGPointMake([self handleActualWidth]/2 + (endPoint.x - startPoint.x)*self.value,
                                     endPoint.y);
    
//    NSLog(@"drawRect, trackPoint = (%d, %d)", (int)trackPoint.x, (int)trackPoint.y);
    
    CGContextBeginPath(ctx);
    
    // Define line cap
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //Set the stroke color
    [self.trackColor setStroke];
    
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, trackPoint.x, trackPoint.y);
    
    //draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    /** Draw the handle **/
    
    CGContextSaveGState(ctx);
    
    //I Love shadows
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), self.handleShadowSize, self.trackColor.CGColor);
    
    //Draw It!
    [self.trackColor set];
    CGContextFillEllipseInRect(ctx,
                               CGRectMake(trackPoint.x - self.handleSize/2,
                                          trackPoint.y - self.handleSize/2,
                                          self.handleSize,
                                          self.handleSize));
    
    CGContextRestoreGState(ctx);
}

- (CGRect)frameForSliderLineWithParentSize:(CGSize)parentSize
{
    CGFloat actualHandleWidth = [self handleActualWidth];
    return CGRectMake(actualHandleWidth/2,
                      (parentSize.height - actualHandleWidth)/2,
                      parentSize.width - actualHandleWidth,
                      actualHandleWidth);
}

- (CGFloat)handleActualWidth
{
    return (self.handleSize + self.handleShadowSize * 2);
}

@end
