//
//  ZJSImagePickerNavigationController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/17.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImagePickerController.h"
#import "ZJSImageAlbumsViewController.h"


@interface ZJSImagePickerController ()

@end

@implementation ZJSImagePickerController

-(instancetype)init{
    ZJSImageAlbumsViewController *vc =[[ZJSImageAlbumsViewController alloc] init];
    
    self = [super initWithRootViewController:vc];
    if (self) {
        self.maxCount = 0;
       
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

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

@end
