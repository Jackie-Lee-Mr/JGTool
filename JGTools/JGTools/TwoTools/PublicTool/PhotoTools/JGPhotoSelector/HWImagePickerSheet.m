//
//  HWImagePickerSheet.m
//  PhotoSelector
//
//  Created by 洪雯 on 2017/1/12.
//  Copyright © 2017年 洪雯. All rights reserved.
//

#import "HWImagePickerSheet.h"
#import "QJActionSheetNoCancle.h"


@interface HWImagePickerSheet ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation HWImagePickerSheet
-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_arrSelected) {
            self.arrSelected = [NSMutableArray array];
        }
    }
    return self;
}

//显示选择照片提示Sheet
-(void)showImgPickerActionSheet {
    
    
    
    QJActionSheetNoCancle *action = [[QJActionSheetNoCancle alloc] initWithTitles:@[@"拍照",@"相册"]];
    WEAKSELF;
    action.backInfo = ^(NSString *title) {
        [weakSelf SelectPictureWithTitle:title];
    };
    [action showView];
}

- (void)SelectPictureWithTitle:(NSString *)title {
    
    //    NSInteger way = [title isEqualToString:@"相册"] ? 1 : 2;
    
    if ([title isEqualToString:@"相册"]) {
        [self loadImgDataAndShowAllGroup];
    }else {
        
        if (!imaPic) {
            imaPic = [[UIImagePickerController alloc] init];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            imaPic.delegate = self;
            UIViewController *VC = [JGCommonTools getCurrentVC];
            [VC presentViewController:imaPic animated:NO completion:nil];
        }
    }
    
}



#pragma mark - 加载照片数据
- (void)loadImgDataAndShowAllGroup{
    if (!_arrSelected) {
        self.arrSelected = [NSMutableArray array];
    }
    [[MImaLibTool shareMImaLibTool] getAllGroupWithArrObj:^(NSArray *arrObj) {
        if (arrObj && arrObj.count > 0) {
            self.arrGroup = arrObj;
            if ( self.arrGroup.count > 0) {
                MShowAllGroup *svc = [[MShowAllGroup alloc] initWithArrGroup:self.arrGroup arrSelected:self.arrSelected];
                svc.delegate = self;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
                if (_arrSelected) {
                    svc.arrSeleted = _arrSelected;
                    svc.mvc.arrSelected = _arrSelected;
                }
                svc.maxCout = _maxCount;
                
                UIViewController *VC = [JGCommonTools getCurrentVC];
                [VC presentViewController:nav animated:YES completion:nil];
            }
        }
    }];
}
#pragma mark - 拍照获得数据
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *theImage = nil;
    // 判断，图片是否允许修改
    if ([picker allowsEditing]){
        //获取用户编辑之后的图像
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        // 照片的元数据参数
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (theImage) {
        //保存图片到相册中
        MImaLibTool *imgLibTool = [MImaLibTool shareMImaLibTool];
        [imgLibTool.lib writeImageToSavedPhotosAlbum:[theImage CGImage] orientation:(ALAssetOrientation)[theImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {
            } else {
                
                //获取图片路径
                [imgLibTool.lib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    if (asset) {
                        
                        [_arrSelected addObject:asset];
                        [self finishSelectImg];
                        [picker dismissViewControllerAnimated:NO completion:nil];
                    }
                } failureBlock:^(NSError *error) {
                    
                }];
            }
        }];
    }
    
}
#pragma mark - 完成选择后返回的图片Array(ALAsset*)
- (void)finishSelectImg{
    //正方形缩略图
    NSMutableArray *thumbnailImgArr = [NSMutableArray array];
    
    for (ALAsset *set in _arrSelected) {
        CGImageRef cgImg = [set thumbnail];
        UIImage* image = [UIImage imageWithCGImage: cgImg];
        [thumbnailImgArr addObject:image];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(getSelectImageWithALAssetArray:thumbnailImageArray:)]) {
        [self.delegate getSelectImageWithALAssetArray:_arrSelected thumbnailImageArray:thumbnailImgArr];
    }
}

@end
