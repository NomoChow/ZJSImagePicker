//
//  ALAssetsLibraryManager.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/18.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSAssetsLibraryManager.h"


@implementation ZJSAssetsLibraryManager


+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}
@end
