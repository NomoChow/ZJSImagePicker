//
//  ZJSImageBrowserTopView.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/20.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImageBrowserTopView.h"

@interface ZJSImageBrowserTopView()


@end

@implementation ZJSImageBrowserTopView

+(instancetype)imageBrowserTopView{
    ZJSImageBrowserTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"ZJSImageBrowserTopView" owner:nil options:nil] firstObject];
    
    return topView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)selected{
    return self.rightButton.selected;
}

-(void)setSelected:(BOOL)selected{
    self.rightButton.selected = selected;
}

- (IBAction)leftButtonTapped:(id)sender {
    if ([self.topViewDelegate respondsToSelector:@selector(topViewLeftTappped:)]) {
        [self.topViewDelegate topViewLeftTappped:self];
    }
}
- (IBAction)rightButtonTapped:(id)sender {
    if ([self.topViewDelegate respondsToSelector:@selector(topViewRightTappped:)]) {
        [self.topViewDelegate topViewRightTappped:self];
    }
}



@end
