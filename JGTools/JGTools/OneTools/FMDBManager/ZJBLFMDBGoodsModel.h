//
//  ZJBLFMDBGoodsModel.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/30.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJBLFMDBGoodsModel : NSObject

//主键(TEXT)
@property (nonatomic, copy) NSString *UNITID_ID;
//商品id(INTEGER)
@property (nonatomic, copy) NSString *GOODS_ID;
//商品规格id(INTEGER)
@property (nonatomic, copy) NSString *UNIT_ID;
//商品名称(VARCHAR(32))
@property (nonatomic, copy) NSString *GOODS_NAME;
//购买数量(INTEGER)
@property (nonatomic, copy) NSString *BUY_NUM ;
//最大购买数量(INTEGER) 实际是库存与最大购买量的最小值
@property (nonatomic, copy) NSString *MAX_BUY_NUM ;
//商品图片(VARCHAR(32))
@property (nonatomic, copy) NSString *GOODS_IMG ;
//规格名称(VARCHAR(32))
@property (nonatomic, copy) NSString *STANDARD_NAMR;
//商品价格区间(VARCHAR(32))
@property (nonatomic, copy) NSString *PRICE_RANGE;
//仓库代码(VARCHAR(32))
@property (nonatomic, copy) NSString *HOURSE_CODE;
//仓库名称(VARCHAR(32))
@property (nonatomic, copy) NSString *HOURSE_NAME;


//活动ID(INTEGER)
@property (nonatomic, copy) NSString *PROMOTION_ID;
//是否支持满减(INTEGER)
@property (nonatomic, copy) NSString *ISFULL_RE;
//是否支持提货券(INTEGER)
@property (nonatomic, copy) NSString *ISSUP_VOU;


//是否启用起送限制(INTEGER) 1.启用
@property (nonatomic, copy) NSString *USE_SF;
//起送数量(INTEGER)
@property (nonatomic, copy) NSString *START_SN;
//起订种类(INTEGER)
@property (nonatomic, copy) NSString *CLASS_NUM;
//起送金额(INTEGER)
@property (nonatomic, copy) NSString *DEL_MA;


//校验（如库存不足）(VARCHAR(32))
@property (nonatomic, copy) NSString *GOOD_CHECK;
//Table头部 编辑(INTEGER)
@property (nonatomic, copy) NSString *EDIT;
//Table Cell选中状态(INTEGER)
@property (nonatomic, copy) NSString *EDIT_STATE;


/******************* 辅助字段 ***********************/
// 最小数量
@property (nonatomic, assign) NSInteger MIN_NUM;

@end
