//
//  ZJSImageCollectionViewCell.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImageCollectionViewCell.h"

@implementation ZJSImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setAsset:(ALAsset *)asset{

    if (_asset!=asset) {
        _asset = asset;
        self.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    }
  

}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    NSLog(@"frame");
}

-(void)setSelected:(BOOL)selected{
    
    BOOL temp = self.selected;
    [super setSelected:selected];
    
    self.selectionButton.selected = selected;
    
    if (temp!=selected) {
        if (selected) {
            self.selectionButton.hidden = NO;
            self.selectionButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
            [UIView animateWithDuration:0.2 animations:^{
                
                self.selectionButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    // self.selectionButton.transform = CGAffineTransformScale(self.selectionButton.transform, 1, 1);
                    
                    self.selectionButton.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    
                }];
            }];
            self.maskView.hidden = NO;
            
        }else{
            self.selectionButton.hidden = YES;
            self.maskView.hidden = YES;
        }
    }
}

@end
