//
//  ZJSImageBrowserViewController.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/18.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSImageView.h"



@interface ZJSImageBrowserViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ZJSImageViewDelegate>

@property (nonatomic,strong) NSMutableArray *images;
/**当前显示的序号*/
@property (nonatomic) NSUInteger currentIndex;

@property (nonatomic,strong) UICollectionView *collectionView;

@end




#pragma mark - 样式一：选择
@protocol ZJSImageBrowserStyle1Delegate <NSObject>

-(void)imageBrowserSelectComplete:(NSArray*)array;

@end

/**样式一：选择*/
@interface ZJSImageBrowserStyle1 : ZJSImageBrowserViewController

@property (nonatomic,weak) id<ZJSImageBrowserStyle1Delegate> imageBrowserDelegate;

@end

#pragma mark - 样式二：删除
@protocol ZJSImageBrowserStyle2Delegate <NSObject>

-(void)imageBrowserSelectionChangedAtIndex:(NSUInteger)index;

@end

/**样式二：删除*/
@interface ZJSImageBrowserStyle2 : ZJSImageBrowserViewController

@property (nonatomic,weak) id<ZJSImageBrowserStyle2Delegate> imageBrowserDelegate;

@end