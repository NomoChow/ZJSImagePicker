//
//  ZJSImagePickerBottomView.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/17.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImagePickerBottomView.h"
#import "ZJSCountView.h"

#define SUBMIT_INFO_FORMAT "完成(%li)"


@interface ZJSImagePickerBottomView ()

@property (nonatomic,strong) ZJSCountView *submitView;

@end

@implementation ZJSImagePickerBottomView

+(instancetype)bottomView{
    
    
    ZJSImagePickerBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"ZJSImagePickerBottomView" owner:nil options:nil] lastObject];
    
    return bottomView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{

    [self addSubmitView];
}

-(ZJSCountView *)submitView{
    if (!_submitView) {
        _submitView = [ZJSCountView countView];
        _submitView.translatesAutoresizingMaskIntoConstraints = NO;
        _submitView.backgroundColor = [UIColor clearColor];
        [_submitView.submitButton addTarget:self action:@selector(submitTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    
    }
    return _submitView;
}

-(void)addSubmitView{
    [self insertSubview:self.submitView atIndex:0];

    NSDictionary *views = @{@"submitView":self.submitView};
    
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"[submitView(100)]-8-|" options:0 metrics:nil views:views];
    NSLayoutConstraint *constraintV = [NSLayoutConstraint constraintWithItem:self.submitView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.submitView.superview attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
    
    [self addConstraint:constraintV];
    [self addConstraints:constraintsH];
    //[self addConstraints:constraintsV];

}

-(void)setSelectedCount:(int)selectedCount{
    _selectedCount = selectedCount;
    
    [self.submitView setCount:selectedCount];
    if (selectedCount>0) {
        self.preViewButton.enabled = YES;
       // self.submitButton.enabled = YES;
       // [self.submitButton setTitle:[NSString stringWithFormat:@SUBMIT_INFO_FORMAT,selectedCount] forState:UIControlStateNormal];
    }else{
        self.preViewButton.enabled = NO;
       // self.submitButton.enabled = NO;
    }
}



- (IBAction)previewTapped:(UIButton *)sender {
    if ([self.bottomViewDelegate respondsToSelector:@selector(bottomViewPreviewTapped:)]) {
        [self.bottomViewDelegate bottomViewPreviewTapped:self];
    }
    
    if (self.previewBlock) {
        self.previewBlock();
    }
}

- (void)submitTapped:(UIButton *)sender {
    
    if ([self.bottomViewDelegate respondsToSelector:@selector(bottomViewSubmitTapped:)]) {
        [self.bottomViewDelegate bottomViewSubmitTapped:self];
    }
    
    if (self.submitBlock) {
        self.submitBlock();
    }
}


@end
