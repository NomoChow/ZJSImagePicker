//
//  ZJSCountButton.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/17.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSCountView.h"

@implementation ZJSCountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+(instancetype)countView{

    return [[[NSBundle mainBundle] loadNibNamed:@"ZJSCountView" owner:nil options:nil] lastObject];
}



-(void)awakeFromNib{
    _count= -1;
    self.count = 0;
    
    self.countLabel.layer.cornerRadius = 10.5;
    self.countLabel.layer.masksToBounds = YES;
    
}



#pragma mark - setter

-(void)setCount:(int)count{
    if ( _count != count) {
         _count = count;
        
        if (_count>0) {
            
            self.countLabel.text = [NSString stringWithFormat:@"%i",_count];
            self.countLabel.hidden = NO;
            self.submitButton.enabled = YES;
            
            self.countLabel.transform = CGAffineTransformMakeScale(0.7, 0.7);
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.countLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.2 animations:^{
                    self.countLabel.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    
                }];
            }];
            
        }else{
            
            self.countLabel.hidden = YES;
            self.submitButton.enabled = NO;
            
            
            
        }
        
        NSLog(@"%@",self.userInteractionEnabled?@"YES":@"NO");
    }
}

//- (IBAction)submitTapped:(UIButton *)sender {
//    
//    if (self.submitBlock) {
//        self.submitBlock();
//    }
//}




@end
