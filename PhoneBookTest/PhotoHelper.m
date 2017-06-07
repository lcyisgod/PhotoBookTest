//
//  PhotoHelper.m
//  PhoneBookTest
//
//  Created by 小龙虾 on 2017/6/6.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import "PhotoHelper.h"
#import <Photos/Photos.h>

static PhotoHelper *helper = nil;
@interface PhotoHelper ()
@property(nonatomic, strong)NSMutableArray *imageAry;
@property(nonatomic, assign)CGSize sizeImage;
@end
@implementation PhotoHelper
+(PhotoHelper *)defatultPhotoHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[PhotoHelper alloc] init];
    });
    return helper;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.imageAry = [NSMutableArray array];
        self.sizeImage = CGSizeMake(150, 150);
    }
    return self;
}

-(void)setImageSize:(CGSize)size
{
    if (size.width > [UIScreen mainScreen].bounds.size.width) {
        size.width = [UIScreen mainScreen].bounds.size.width;
    }
    
    if (size.height > [UIScreen mainScreen].bounds.size.height) {
        size.height = [UIScreen mainScreen].bounds.size.height;
    }
    self.sizeImage = size;
}


-(NSArray *)returnImgAry
{
    [self.imageAry removeAllObjects];
    //获取所有的资源的集合,并按照资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    //获取相机胶卷的所有图片
    PHFetchResult *assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
    __weak typeof(self) weakSelf = self;
    
    for (PHAsset *asset in assets) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        
        //设置显示模式
        /*
         PHImageRequestOptionsResizeModeNone       //选了这个就不会管传如的size了 ，要自己控制图片的大小，建议还是选Fast
         PHImageRequestOptionsResizeModeFast       //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
         PHImageRequestOptionsResizeModeExate      //精确的加载与传入size相匹配的图像
         */
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        option.synchronous = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        CGSize screenSize = CGSizeMake(100, 100);
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:screenSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [weakSelf.imageAry addObject:result];
        }];
    }
    return self.imageAry;
}

@end
