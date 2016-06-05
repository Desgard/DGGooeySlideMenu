//
//  ViewController.m
//  DGGooeySlide
//
//  Created by 段昊宇 on 16/6/4.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ViewController.h"
#import "DGGooeySlideMenu.h"

@interface ViewController ()

@property (nonatomic, strong) DGGooeySlideMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menu = [[DGGooeySlideMenu alloc] initWithTitles:@[@"123", @"123" ]];
    
}

- (IBAction)clickButton:(id)sender {
    [self.menu trigger];
}
@end
