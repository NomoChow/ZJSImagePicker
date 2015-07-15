//
//  TestViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/19.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIScrollViewDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.image = self.image;
   // self.scrollview.zooming
    
    self.scrollview.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
