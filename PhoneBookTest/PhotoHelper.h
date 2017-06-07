//
//  PhotoHelper.h
//  PhoneBookTest
//
//  Created by 小龙虾 on 2017/6/6.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoHelper : NSObject
+(PhotoHelper *)defatultPhotoHelper;
//设置压缩图片的尺寸
-(void)setImageSize:(CGSize)size;
-(NSArray *)returnImgAry;
@end
