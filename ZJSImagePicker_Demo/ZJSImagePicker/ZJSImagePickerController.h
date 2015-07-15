//
//  ZJSImagePickerNavigationController.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/17.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZJSImagePickerControllerDelegate <NSObject>

-(void)imagePickerComleted:(NSArray*)images;

@end

@interface ZJSImagePickerController : UINavigationController

@property (nonatomic,weak) id<ZJSImagePickerControllerDelegate> pickerDelegate;

@property (nonatomic) NSUInteger maxCount;

@end
