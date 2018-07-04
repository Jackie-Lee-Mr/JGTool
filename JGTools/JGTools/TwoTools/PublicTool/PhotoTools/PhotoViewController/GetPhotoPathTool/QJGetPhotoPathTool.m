//
//  QJGetPhotoPathTool.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/19.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJGetPhotoPathTool.h"
#import "PHTool.h"
//#import "HUDManager.h"


@interface QJGetPhotoPathTool() < UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) ReturnBackInfo backInfo;
@property (nonatomic, assign) CGSize Size;
@property (nonatomic, assign) NSInteger Type;

@end


@implementation QJGetPhotoPathTool

HMSingletonM(QJGetPhotoPathTool)


/**
 从相册或者图库选择 单张照片 上传服务器
 获取服务器图片路径
 
 @param way 1:图库 2:拍照
 @param type 1-商品,2-文件,3-身份证,4-新闻,5-头像,6-其他
 @param info 完成回调 返回路劲
 */
- (void)GetPhotoPathWithMethord:(NSInteger)way andType:(NSInteger)type andSize:(CGSize)PhotoSize complete:(ReturnBackInfo)info {
    
    self.backInfo = info;
    self.Type = type;
    self.Size = PhotoSize;
    
    if (way == 1) {
        
        WEAKSELF;
        [PHTool showAssetWithCount:1 mediaType:OnlyPhotosType isCamera:NO isCropping:YES complete:^(id result) {
            //
            
            UIImage *Image = result;
            [weakSelf UpDataImageWithImage:Image toSize:weakSelf.Size];
        }];
        
        
    }else if (way == 2) {
        
        //创建UIImagePickerController对象
        UIImagePickerController *imagePc = [[UIImagePickerController alloc] init];

        //设置资源类型
        imagePc.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置是否支持后续操作 YES 支持 NO 不支持
        imagePc.allowsEditing = YES;
        //设置代理
        imagePc.delegate = self;
        //模态视图方式跳转
        UIViewController *vc = [self getCurrentVC];
        [vc presentViewController:imagePc animated:YES completion:nil];
    }
}



#pragma mark - UIImagePickerControllerDelegate -
//点击了choose完成按钮实现的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //    JGLog(@"====  %@",info);
    
    //选取资源类型 media类型
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //判断当前图片是否是公共图片 public.image
    
    UIImage *orImage;
    if ([type isEqualToString:@"public.image"]) {
        orImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self UpDataImageWithImage:orImage toSize:self.Size];
}




/**
 给定一张图片 获取服务器图片路径 (主要上传身份证正反面图片)
 
 @param image 给定一张图片
 @param type 1-商品,2-文件,3-身份证,4-新闻,5-头像,6-其他
 @param PhotoSize 图片尺寸
 @param info 完成回调 返回路劲
 */
- (void)GetPhotoPathWithImage:(UIImage *)image andType:(NSInteger)type toSize:(CGSize)PhotoSize complete:(ReturnBackInfo)info {
    
    self.backInfo = info;
    self.Type = type;
    
    [self UpDataImageWithImage:image toSize:PhotoSize];

    
}





- (void)UpDataImageWithImage:(UIImage *)image toSize:(CGSize)size {
        
    UIImage *originImage = [UIImage compressOriginalImage:image toSize:size];

    NSData *data;
    if (UIImagePNGRepresentation(originImage)) {
        
        data = UIImagePNGRepresentation(originImage);
        
    } else {
        data = UIImageJPEGRepresentation(originImage, 1);
    }
    
    
    //显示指示器
    [QJCustomHUD showMessage:@"正在上传"];
    
    //type:1-商品,2-文件,3-身份证,4-新闻,5-头像,6-其他
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"] = QJUSER_ID;
    parameters[@"type"] = [NSString stringWithFormat:@"%ld",self.Type];
    parameters[@"name"] = [JGCommonTools currentTimeStr];
    parameters[@"ext"] = [JGCommonTools imageTypeWithData:data];
    parameters[@"base64"] = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];;
    
    WEAKSELF;
    [QJHttpManager HttpRequestDataWithUrlString:@"Base/UploadSingleImage" Aarameters:parameters httpMthod:POST Success:^(id data, QJHttpResponseState responseState) {
        
        [QJCustomHUD hideHUD];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *url = data;
            if (weakSelf.backInfo) {
                weakSelf.backInfo(url);
            }
        });
        
    } failure:^(QJHttpResponseState responseState, NSError *error, NSString *message) {
        //隐藏指示器
        [QJCustomHUD hideHUD];
        [QJCustomHUD showError:message];
    }];
}



//点击了取消按钮执行
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}





@end
