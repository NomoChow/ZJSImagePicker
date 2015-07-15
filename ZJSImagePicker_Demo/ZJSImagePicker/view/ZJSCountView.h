//
//  ZJSCountButton.h
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/17.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ButtonTappedBlock)();

@interface ZJSCountView : UIView

+(instancetype)countView;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

//@property (nonatomic,copy) ButtonTappedBlock submitBlock;

@property (nonatomic)int count;
@end
