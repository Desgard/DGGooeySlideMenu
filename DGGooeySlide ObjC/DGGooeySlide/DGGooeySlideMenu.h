//
//  DGGooeySlideMenu.h
//  DGGooeySlide
//
//  Created by 段昊宇 on 16/6/4.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGGooeySlideMenu : UIView



-(id)initWithTitles:(NSArray *)titles;

-(id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;

-(void)trigger;


@end
