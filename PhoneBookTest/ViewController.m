//
//  ViewController.m
//  PhoneBookTest
//
//  Created by 小龙虾 on 2017/6/6.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ImageCell.h"
#import "PhotoHelper.h"
#import <Photos/Photos.h>


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)NSArray *imageAry;
@property(nonatomic, strong)UICollectionView *baseCollect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createViews];
    PhotoHelper *photoHelper = [PhotoHelper defatultPhotoHelper];
    [photoHelper setImageSize:CGSizeMake(300, 300)];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                NSLog(@"拒绝了");
            }else if (status == PHAuthorizationStatusAuthorized){
                self.imageAry = [photoHelper returnImgAry];
                [self.baseCollect reloadData];
            }
        });
    }];
}

-(void)createViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.itemSize = CGSizeMake(self.view.frame.size.width/4, 100);
    self.baseCollect = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.baseCollect.dataSource = self;
    self.baseCollect.delegate = self;
    self.baseCollect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.baseCollect];
    [self.baseCollect registerClass:[ImageCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}
#pragma mark-
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell upDataImage:[self.imageAry objectAtIndex:indexPath.row]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageAry.count;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
