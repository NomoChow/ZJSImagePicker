//
//  ZJSImagePickerBottomView.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/17.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJSImagePickerBottomView;

typedef void(^ButtonTappedBlock)();

@protocol ZJSImagePickerBottomViewDelegate <NSObject>

-(void)bottomViewSubmitTapped:(ZJSImagePickerBottomView*)sender;
@optional
-(void)bottomViewPreviewTapped:(ZJSImagePickerBottomView*)sender;

@end

@interface ZJSImagePickerBottomView : UIView

+(instancetype)bottomView;
@property (weak, nonatomic) IBOutlet UIButton *preViewButton;
//@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic,copy) ButtonTappedBlock previewBlock;
@property (nonatomic,copy) ButtonTappedBlock submitBlock;
@property (nonatomic) NSUInteger selectedCount;
@property (nonatomic,weak) id<ZJSImagePickerBottomViewDelegate> bottomViewDelegate;

@end
