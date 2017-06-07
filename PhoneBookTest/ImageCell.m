//
//  ImageCell.m
//  PhoneBookTest
//
//  Created by 小龙虾 on 2017/6/6.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()
@property(nonatomic, strong)UIImageView *image;
@end
@implementation ImageCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.image];
    }
    return self;
}

-(void)upDataImage:(UIImage *)image
{
    [self.image setImage:image];
}
@end
