//
//  DGGooeySlideMenu.m
//  DGGooeySlide
//
//  Created by 段昊宇 on 16/6/4.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "DGGooeySlideMenu.h"

#define buttonSpace 30
#define menuBlankWidth 80
#define wid [UIScreen mainScreen].bounds.size.width
#define hei [UIScreen mainScreen].bounds.size.height
#define kwid keyWindow.frame.size.width
#define khei keyWindow.frame.size.height
#define swid self.frame.size.width
#define shei self.frame.size.height

@interface DGGooeySlideMenu() {
    UIVisualEffectView *blurView;
    UIView *helperSideView;
    UIView *helperCenterView;
    UIWindow *keyWindow;
    BOOL triggered;
    CGFloat diff;
    UIColor *_menuColor;
    CGFloat menuButtonHeight;
}

@property (nonatomic,strong) CADisplayLink *displayLink;
@property  NSInteger animationCount; // 动画的数量

@end

@implementation DGGooeySlideMenu

#pragma mark - Overite
-(id)initWithTitles:(NSArray *)titles{
    return [self initWithTitles:titles withButtonHeight:40.0f withMenuColor: [UIColor colorWithRed:0 green:175 / 255.f blue: 240 / 255.f alpha:1] withBackBlurStyle:UIBlurEffectStyleDark];
}

-(id)initWithTitles: (NSArray *)titles withButtonHeight: (CGFloat)height withMenuColor: (UIColor *)menuColor withBackBlurStyle: (UIBlurEffectStyle) style {
    
    self = [super init];
    if (self) {
        keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        // 背景设置为模糊效果
        // UIVisualEffectView
        blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:style]];
        blurView.frame = keyWindow.frame;
        blurView.alpha = 0.0f;
        
        // 左下角辅助视图
        helperSideView = [[UIView alloc] initWithFrame: CGRectMake(0, hei + 40, 40, 40)];
        helperSideView.backgroundColor = [UIColor redColor];
        helperSideView.hidden = YES;
        [keyWindow addSubview: helperSideView];
        
        // 中央辅助视图
        helperCenterView = [[UIView alloc] initWithFrame: CGRectMake(wid / 2 - 20, hei + 40, 40, 40)];
        helperCenterView.backgroundColor = [UIColor yellowColor];
        helperCenterView.hidden = YES;
        [keyWindow addSubview: helperCenterView];
        
        // 创建下边界界外的视图
        self.frame = CGRectMake(0, khei + khei / 2 + menuBlankWidth, kwid, khei / 2 + menuBlankWidth);
        self.backgroundColor = [UIColor clearColor];
        [keyWindow insertSubview: self belowSubview: helperSideView];
        
        _menuColor = menuColor;
        menuButtonHeight = height;
        
        // 视图辅助观察颜色
        // self.backgroundColor = [UIColor redColor];
        [self addButton];
    }
    return self;
}

- (void) addButton {
    
}

- (void) drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(0, shei)];
    [path addLineToPoint: CGPointMake(0, shei - khei / 2 )];
    [path addQuadCurveToPoint: CGPointMake(wid, shei - khei / 2)
                 controlPoint: CGPointMake(swid / 2,  diff + menuBlankWidth)];
    [path addLineToPoint: CGPointMake(wid, shei)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
}


- (void) trigger{
    if (!triggered) {
        [keyWindow insertSubview: blurView belowSubview:self];
        [UIView animateWithDuration: 0.618 animations:^{
            self.frame = CGRectMake(0, hei / 2 - menuBlankWidth, wid, hei / 2 + menuBlankWidth);
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration: 1
                              delay: 0.0f
             usingSpringWithDamping: 0.5f
              initialSpringVelocity: 0.9f
                            options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations: ^{
                             helperSideView.center = CGPointMake(20, hei / 2);
                         }
                         completion: ^(BOOL finished) {
                             [self finishAnimation];
                         }];
        
        [UIView animateWithDuration: 0.3 animations: ^{
            blurView.alpha = 1.0f;
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration: 1
                              delay: 0.0f
             usingSpringWithDamping: 0.8f
              initialSpringVelocity: 2.0f
                            options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations: ^{
                             helperCenterView.center = keyWindow.center;
                         }
                         completion: ^(BOOL finished) {
                             if (finished) {
                                 UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(tapToUntrigger)];
                                 [blurView addGestureRecognizer: tapGes];
                                 [self finishAnimation];
                             }
                         }];
        [self animateButtons];
        triggered = YES;
    } else {
        [self tapToUntrigger];
    }
}

- (void) animateButtons{
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        
        UIView *menuButton = self.subviews[i];
        menuButton.transform = CGAffineTransformMakeTranslation(0, -90);
        [UIView animateWithDuration: 0.7
                              delay: i * (0.3 / self.subviews.count)
             usingSpringWithDamping: 0.6f
              initialSpringVelocity: 0.0f
                            options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations: ^{
                             menuButton.transform =  CGAffineTransformIdentity;
                         }
                         completion: NULL];
    }
    
}

- (void) tapToUntrigger{
    
    [UIView animateWithDuration: 0.618 animations:^{
        self.frame = CGRectMake(0, khei + khei / 2 + menuBlankWidth, kwid, khei / 2 + menuBlankWidth);
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration: 1
                          delay: 0.0f
         usingSpringWithDamping: 0.6f
          initialSpringVelocity: 0.9f
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations: ^{
                         helperSideView.center = CGPointMake(20, hei + 20);
                     }
                     completion: ^(BOOL finished) {
                         [self finishAnimation];
                     }];
    
    [UIView animateWithDuration:0.3 animations: ^{
        blurView.alpha = 0.0f;
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration: 1
                          delay: 0.0f
         usingSpringWithDamping: 0.7f
          initialSpringVelocity: 2.0f
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations: ^{
                         helperCenterView.center = CGPointMake(wid / 2, hei + 20);
                     }
                     completion: ^(BOOL finished) {
        [self finishAnimation];
    }];
    
    triggered = NO;
    
}

//动画之前调用
- (void) beforeAnimation{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(displayLinkAction:)];
        [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

//动画完成之后调用
- (void) finishAnimation{
    self.animationCount --;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void) displayLinkAction: (CADisplayLink *)dis{
    
    CALayer *sideHelperPresentationLayer   =  (CALayer *)[helperSideView.layer presentationLayer];
    CALayer *centerHelperPresentationLayer =  (CALayer *)[helperCenterView.layer presentationLayer];
    
    CGRect centerRect = [[centerHelperPresentationLayer valueForKeyPath:@"frame"] CGRectValue];
    CGRect sideRect = [[sideHelperPresentationLayer valueForKeyPath:@"frame"] CGRectValue];
    
    diff = sideRect.origin.y - centerRect.origin.y;

    
    // 重新布局方法
    // 在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘
    // 默认runloop周期 60Hz
    [self setNeedsDisplay];
}

@end
