//
//  ViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "ZJSImagePickerController.h"
#import "Test2ViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "ZJSImageBrowserViewController.h"

@interface ViewController ()<ZJSImagePickerControllerDelegate>

@property (nonatomic,strong) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
    [self.imageView addGestureRecognizer:tap];
    
    [self.navigationItem setPrompt:@"asdasdasdsad"];
    
    self.title = @"adasdasd";
  
    
    [UIView transitionWithView:<#(UIView *)#> duration:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>];
}

-(void)imageTapped{
    ZJSImageBrowserStyle2 *vc = [ZJSImageBrowserStyle2 new];
    vc.images = [self.images mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getLibraries:(id)sender {
//    ZJSImageAlbumsViewController *vc =[[ZJSImageAlbumsViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    if (self.images.count>0) {
        ZJSImageBrowserViewController *vc = [[ZJSImageBrowserViewController alloc] init];
        vc.images = self.images;
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        ZJSImagePickerController *vc = [[ZJSImagePickerController alloc] init];
        vc.pickerDelegate = self;
        vc.maxCount = (9 - self.images.count);
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

-(void)imagePickerComleted:(NSArray *)images{

    NSLog(@"images:%@",images);
    
    [self.images addObjectsFromArray:images];
    
    ALAsset *asset = images[0];
    self.imageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
   // ALAssetsLibrary
    

    
}

-(NSMutableArray *)images{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([segue.identifier isEqualToString: @"testVc"]) {
        ALAsset *asset = self.images[0];
        TestViewController *tvc = (TestViewController*)(segue.destinationViewController);
        tvc.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
    }else if([segue.identifier isEqualToString: @"test2Vc"]){
    
        ALAsset *asset = self.images[0];
        Test2ViewController *tvc = (Test2ViewController*)(segue.destinationViewController);
        tvc.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
    }
}


@end
