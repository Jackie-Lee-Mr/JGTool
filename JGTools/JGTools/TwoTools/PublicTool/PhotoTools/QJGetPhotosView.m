//
//  QJGetPhotosView.m
//  LH_QJ
//
//  Created by 郭军 on 2018/6/1.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJGetPhotosView.h"
#import "HWImagePickerSheet.h"


@interface GetPhotosPicCell : UICollectionViewCell
//图像
@property (nonatomic, strong) UIImageView *profilePhoto;

@property (nonatomic, strong) UIButton *closeButton;

@property(nonatomic,strong) UIImageView *BigImageView;


/** 查看大图 */
- (void)setBigImageViewWithImage:(UIImage *)image;

@end

@implementation GetPhotosPicCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _profilePhoto = [UIImageView new];
        //        _profilePhoto.image = Image(@"add_picture");
        
        //
        _closeButton = [UIButton new]; //close@3x  order_cancle
        [_closeButton setBackgroundImage:Image(@"order_cancle") forState:UIControlStateNormal];
        
        [self addSubview:_profilePhoto];
        [self addSubview:_closeButton];
        
        
        
        [_profilePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(5);
            make.top.equalTo(self.mas_top).mas_offset(-5);
            make.width.height.equalTo(@(20));
        }];
    }
    return self;
}


/** 查看大图 */
- (void)setBigImageViewWithImage:(UIImage *)img{
    if (_BigImageView) {
        //如果大图正在显示，还原小图
        _BigImageView.frame = _profilePhoto.frame;
        _BigImageView.image = img;
    }else{
        _BigImageView = [[UIImageView alloc] initWithImage:img];
        _BigImageView.frame = _profilePhoto.frame;
        [self insertSubview:_BigImageView atIndex:0];
    }
    _BigImageView.contentMode = UIViewContentModeScaleToFill;
}

@end





@interface QJGetPhotosView()<UICollectionViewDelegate,UICollectionViewDataSource,JJPhotoDelegate,HWImagePickerSheetDelegate>{
    NSString *pushImageName;
}

//图片列表
@property (nonatomic, strong) UICollectionView *CollectionView;

//选择的图片数据
@property(nonatomic,strong) NSMutableArray *arrSelected;

//方形压缩图image 数组
@property(nonatomic,strong) NSMutableArray * imageArray;

//大图image 数组
@property(nonatomic,strong) NSMutableArray * bigImageArray;

//大图image 二进制
@property(nonatomic,strong) NSMutableArray * bigImgDataArray;

@property (nonatomic, strong) HWImagePickerSheet *imgPickerActionSheet;

@end

static NSString * const GetPhotosPicCellId = @"GetPhotosPicCellId";

@implementation QJGetPhotosView


- (UICollectionView *)CollectionView {
    if (!_CollectionView) {
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _CollectionView.backgroundColor = [UIColor whiteColor];
        _CollectionView.delegate = self;
        _CollectionView.dataSource = self;
        _CollectionView.scrollsToTop = NO;
        _CollectionView.clipsToBounds = YES;
        _CollectionView.showsVerticalScrollIndicator = NO;
        _CollectionView.showsHorizontalScrollIndicator = NO;
        
        //                _CollectionView.alwaysBounceHorizontal = NO; //数据不够一屏时上下滚动
        
        [_CollectionView registerClass:[GetPhotosPicCell class] forCellWithReuseIdentifier:GetPhotosPicCellId];
        
        if(_imageArray.count == 0)
        {
            _imageArray = [NSMutableArray array];
        }
        if(_bigImageArray.count == 0)
        {
            _bigImageArray = [NSMutableArray array];
        }
        pushImageName = @"add_picture";
        
        _CollectionView.scrollEnabled = NO;
    }
    return _CollectionView;
}






- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:self.CollectionView];
        
        [_CollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@(60));
        }];
    }
    return self;
}





#pragma mark - UICollectionViewDataSource
//指定有多少个子视图
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count+1;
}

//指定子视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GetPhotosPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GetPhotosPicCellId forIndexPath:indexPath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (indexPath.row == _imageArray.count) {
            [cell.profilePhoto setImage:[UIImage imageNamed:pushImageName]];
            cell.closeButton.hidden = YES;
        }
        else{
            [cell.profilePhoto setImage:_imageArray[indexPath.item]];
            cell.closeButton.hidden = NO;
        }
        [cell setBigImageViewWithImage:nil];
        cell.profilePhoto.tag = [indexPath item];
        
    });
    
    
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto .userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



//返回每个子视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, 50);
}

//设置每个子视图的缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(5.0, 10.0, 0.0, 10.0);
}



//设置子视图上下之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5.0;
}

//设置子视图左右之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return  0.0;
}



#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_imageArray.count)) {
        
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        GetPhotosPicCell *cell = (GetPhotosPicCell*)[_CollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImageView || !cell.BigImageView.image) {
            
            [cell setBigImageViewWithImage:[self getBigIamgeWithALAsset:_arrSelected[index]]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImageView] selecImageindex:0];
    }
}
- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [_bigImgDataArray addObject:imageData];
    
    return [UIImage imageWithData:imageData];
}

#pragma mark - 选择图片
- (void)addNewImg{
    if (!_imgPickerActionSheet) {
        _imgPickerActionSheet = [[HWImagePickerSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
    if (_arrSelected) {
        _imgPickerActionSheet.arrSelected = _arrSelected;
    }
    _imgPickerActionSheet.maxCount = self.maxCount;
    [_imgPickerActionSheet showImgPickerActionSheet];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    
    
    [_CollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
    
    for (NSInteger item = sender.tag; item <= _imageArray.count; item++) {
        GetPhotosPicCell *cell = (GetPhotosPicCell*)[_CollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.closeButton.tag--;
        cell.profilePhoto.tag--;
    }
}


/**
 *  相册完成选择得到图片
 */
-(void)getSelectImageWithALAssetArray:(NSArray *)ALAssetArray thumbnailImageArray:(NSArray *)thumbnailImgArray{
    //（ALAsset）类型 Array
    _arrSelected = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    _imageArray = [NSMutableArray arrayWithArray:thumbnailImgArray] ;
    
    if (self.backInfo) {
        self.backInfo(_arrSelected);
    }
    
    [_CollectionView reloadData];
}


#pragma mark - 防止奔溃处理
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    JGLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
//获得大图
- (NSArray*)getBigImageArrayWithALAssetArray:(NSArray*)ALAssetArray{
    _bigImgDataArray = [NSMutableArray array];
    NSMutableArray *bigImgArr = [NSMutableArray array];
    for (ALAsset *set in ALAssetArray) {
        [bigImgArr addObject:[self getBigIamgeWithALAsset:set]];
    }
    _bigImageArray = bigImgArr;
    return _bigImageArray;
}
#pragma mark - 获得选中图片各个尺寸
- (NSArray*)getALAssetArray{
    return _arrSelected;
}

- (NSArray*)getBigImageArray{
    
    return [self getBigImageArrayWithALAssetArray:_arrSelected];
}

- (NSArray*)getSmallImageArray{
    return _imageArray;
}





@end



