//
//  ZJSImageBrowserCell.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/19.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImageBrowserCell.h"

@implementation ZJSImageBrowserCell

- (void)awakeFromNib {
    // Initialization code
   // [self addImageView];
}

-(void)layoutSubviews{
  
    
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    [self.imageView adjustFrame];
}

//-(void)addImageView{
//    self.imageView.translatesAutoresizingMaskIntoConstraints  = NO;
//    [self.contentView addSubview:self.imageView];
//    
//    NSDictionary *views = @{@"imageView":self.imageView};
//    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[imageView]-0-|" options:0 metrics:nil views:views];
//    
//    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:views];
//    
//    [self.contentView addConstraints:ch];
//    [self.contentView addConstraints:cv];
//}
//
//-(ZJSImageView *)imageView{
//    if (!_imageView) {
//        _imageView = [[ZJSImageView alloc] init];
//    }
//    return _imageView;
//}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}
@end
