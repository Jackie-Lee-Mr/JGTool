//
//  ZJBLGoodsManager.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/27.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLGoodsManager.h"
#import "ZJBLFMDBGoodsModel.h"


@interface ZJBLGoodsManager ()

@property (nonatomic, strong)FMDatabase *database;

@end


@implementation ZJBLGoodsManager

HMSingletonM(ZJBLGoodsManager) //创建单例

- (FMDatabase *)database {
    
    if (!_database) {
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"mygoods.db"];
        _database = [FMDatabase databaseWithPath:dbPath];
    }
    return _database;
}

//当所有操作结束之后 别忘记关闭数据库！！不关闭会占用内存或如果其他地方进行对数据库可能出现没有任何效果
- (void)openDatabase {
    //打开数据库
    [self.database open];
}

- (void)closeDatabase {
    //关闭数据库
    [self.database close];
}



//////////////////////////////////    增     ///////////////////////////////////
#pragma mark -  添加一条记录  -
- (void)addSupermarkProductToShopCarWithModel:(ZJBLFMDBGoodsModel *)Model {
    
    //注意：这个方法的参数是一个字符串列表，第一个参数是插入sql语句的字符串，以下参数是要插入的字段值（这里是字段值）
    [self openDatabase];
    
    NSString *insertSql = @"INSERT INTO GOODSLIST(UNITID_ID,USER_ID,GOODS_ID,UNIT_ID, GOODS_NAME,BUY_NUM,MAX_BUY_NUM,GOODS_IMG,STANDARD_NAMR,PRICE_RANGE, HOURSE_CODE,HOURSE_NAME,GOOD_CHECK,EDIT,EDIT_STATE,PROMOTION_ID,ISFULL_RE,ISSUP_VOU,USE_SF,START_SN,CLASS_NUM,DEL_MA) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    [self.database executeUpdate:insertSql,Model.UNITID_ID, USER_ID, Model.GOODS_ID, Model.UNIT_ID,Model.GOODS_NAME, Model.BUY_NUM, Model.MAX_BUY_NUM, Model.GOODS_IMG, Model.STANDARD_NAMR, Model.PRICE_RANGE, Model.HOURSE_CODE,Model.HOURSE_NAME, Model.GOOD_CHECK, Model.EDIT, Model.EDIT_STATE, Model.PROMOTION_ID, Model.ISFULL_RE, Model.ISSUP_VOU,Model.USE_SF,Model.START_SN,Model.CLASS_NUM,Model.DEL_MA];
    
    //同步购买限制数据
    [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE GOODSLIST SET USE_SF='%@' ,START_SN='%@' ,CLASS_NUM='%@', DEL_MA='%@' WHERE HOURSE_CODE='%@' AND USER_ID = '%@'", Model.USE_SF, Model.START_SN,Model.CLASS_NUM,Model.DEL_MA, Model.HOURSE_CODE, USER_ID]];
    
    [self closeDatabase];
}


//////////////////////////////////    删     ///////////////////////////////////
#pragma mark - 删除一条记录 -
- (void)deleteFromProductShopCarWithUNITID_ID:(NSString *)UNITID_ID {
    
    [self openDatabase];
    NSString *sql = @"delete from GOODSLIST where UNITID_ID = ? AND USER_ID = ?";
    [self.database executeUpdate:sql,UNITID_ID, USER_ID];
    [self closeDatabase];
}


//////////////////////////////////    改     ///////////////////////////////////
#pragma mark - 更新商品数量 -
- (void)updataSupermarkProductWithUNITID_ID:(NSString *)UNITID_ID ModifyBuyNum:(NSString *)BuyNum andModel:(ZJBLFMDBGoodsModel *)Model {
    
    //使用specifiModel主要目的是首页加入采购车的同时更新商品阶梯价格
    if (Model != nil) {
        
        //执行更新sql语句 第一个更新sql语句
        //更新的时候习惯性的加上where条件 如果不加会将所有数据的密码和分数全部修改（慎用）不推荐
        [self openDatabase];
        
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET BUY_NUM='%@', PRICE_RANGE = '%@', MAX_BUY_NUM='%@', USE_SF='%@', START_SN='%@', CLASS_NUM='%@', DEL_MA='%@' WHERE UNITID_ID='%@' AND USER_ID ='%@'",BuyNum, Model.PRICE_RANGE, Model.MAX_BUY_NUM,Model.USE_SF,Model.START_SN,Model.CLASS_NUM,Model.DEL_MA, UNITID_ID, USER_ID];
        [self.database executeUpdate:updateSql];
        [self closeDatabase];
        
    }else {
        
        //执行更新sql语句 第一个更新sql语句
        //更新的时候习惯性的加上where条件 如果不加会将所有数据的密码和分数全部修改（慎用）不推荐
        [self openDatabase];
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET BUY_NUM='%@' WHERE UNITID_ID='%@' AND USER_ID ='%@'",BuyNum, UNITID_ID, USER_ID];
        [self.database executeUpdate:updateSql];
        [self closeDatabase];
    }
}


//EDIT_STATE //每一个Cell是否选中 0:未选中 1:选中
//EDIT       //头部右侧 编辑  0: 未编辑 1: 编辑
//EDIT_TITLE //头部左侧 编辑 0:未编辑 1:编辑
//根据 UNITID_ID 修改 每个商品的 编辑状态 是否被选中 未选中:0 选中:1
- (void)updataSingleGoodEditStateWithUNITID_ID:(NSString *)UNITID_ID andEditState:(NSString *)editState {
    
    [self openDatabase];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET EDIT_STATE='%@' WHERE UNITID_ID='%@' AND USER_ID = '%@' AND GOOD_CHECK='%@'",editState, UNITID_ID, USER_ID, @"0"];
    [self.database executeUpdate:updateSql];
    
    //判断当前选中的商品是否为最后一个选中的商品， 如果是 则设置头部左侧 为 选中状态
    //获取仓库编号
    NSString *sql = @"SELECT * FROM GOODSLIST WHERE UNITID_ID = ? AND USER_ID = ?";
    FMResultSet *set = [self.database executeQuery:sql,UNITID_ID, USER_ID];
    NSString *houseCode;
    while ([set next]) {
        houseCode = [set stringForColumn:@"HOURSE_CODE"];
    }
    
    //获取当前仓库下的所有商品
    NSArray *arrayM = [self getSingleGroupAllGoodsWithHouseCode:houseCode];
    //标记
    NSString *editIndex;
    //遍历 商品的编辑状态
    for (ZJBLFMDBGoodsModel *model in arrayM) {
        
        if ([model.EDIT_STATE isEqualToString:@"1"]) continue;
        editIndex = @"exist";
    }
    
    if (![editIndex isEqualToString:@"exist"]) { //不存在 -> 即所有商品处在编辑状态
        [self openDatabase];
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET  EDIT_STATE='%@' WHERE HOURSE_CODE='%@' AND USER_ID = '%@'", @"1", houseCode , USER_ID];
        [self.database executeUpdate:updateSql];
    }
    
    [self closeDatabase];
}


//根据 HOURSE_CODE 修改 每组 编辑状态 是否编辑 未编辑:0 编辑:1
- (void)updateGroupGoodEditStateWithHOURSE_CODE:(NSString *)HOURSE_CODE andEditState:(NSString *)editState {
    
    [self openDatabase];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET EDIT='%@' WHERE HOURSE_CODE='%@' AND USER_ID = '%@'",editState, HOURSE_CODE, USER_ID];
    [self.database executeUpdate:updateSql];
    [self closeDatabase];
}

//根据HOURSE_CODE 修改 每组头部左侧 编辑状态 是否编辑 未编辑:0 编辑:1
- (void)updateGroupGoodTitleEditStateWithHOURSE_CODE:(NSString *)HOURSE_CODE andEditState:(NSString *)titleEdit {
    
    [self openDatabase];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET EDIT_STATE='%@' WHERE HOURSE_CODE='%@' AND USER_ID = '%@' AND GOOD_CHECK='%@'", titleEdit, HOURSE_CODE, USER_ID, @"0"];
    [self.database executeUpdate:updateSql];
    [self closeDatabase];
}

//根据仓库代码获取 每组头部左侧状态 存在未选中 返回NO 否则返回YES
- (BOOL)updataGroupTitleEditStateWithHOURSE_CODE:(NSString *)HOURSE_CODE {
    
    [self openDatabase];
    //获取该仓库 所有 商品数量
    NSString *AllSql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE  USER_ID = '%@' AND HOURSE_CODE='%@'",  USER_ID, HOURSE_CODE];
    FMResultSet *Allset = [self.database executeQuery:AllSql];
    int AllCount = 0;
    while ([Allset next]) {
        AllCount += [[Allset stringForColumn:@"BUY_NUM"] intValue];
    }
    
    //获取该仓库 所有选中 商品数量
    NSString *SelSql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE  USER_ID = '%@' AND HOURSE_CODE='%@' AND EDIT_STATE='%@' AND GOOD_CHECK='%@'", USER_ID, HOURSE_CODE, @"1", @"0"];
    
    FMResultSet *Selset = [self.database executeQuery:SelSql];
    int SelCount = 0;
    while ([Selset next]) {
        SelCount += [[Selset stringForColumn:@"BUY_NUM"] intValue];
    }
    
    //获取该仓库 所有有问题 商品数量
    NSString *QueSql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE  USER_ID = '%@' AND HOURSE_CODE='%@' AND GOOD_CHECK!='%@'", USER_ID, HOURSE_CODE, @"0"];
    
    FMResultSet *Queset = [self.database executeQuery:QueSql];
    int QueCount = 0;
    while ([Queset next]) {
        QueCount += [[Queset stringForColumn:@"BUY_NUM"] intValue];
    }
    
    [self closeDatabase];
    return (AllCount != 0) && (AllCount == (SelCount + QueCount));
}


//每次用户进入重置所有编辑为非编辑
- (void)resetUesrShopCarEditState {
    [self openDatabase];
    
    if (![self isTableOK:@"GOODSLIST"]) return;
    
    [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE GOODSLIST SET EDIT='0', EDIT_STATE='0' WHERE USER_ID = '%@'", USER_ID]];
    
    [self closeDatabase];
}

//点击全选 修改 所有商品选中状态
- (void)updateGoodStateWithState:(NSString *)State {
    
    [self openDatabase];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET EDIT_STATE='%@' WHERE GOOD_CHECK='%@' AND USER_ID = '%@'", State, @"0", USER_ID];
    [self.database executeUpdate:updateSql];
    [self closeDatabase];
}


//采购页编辑 点击商品规格 更换商品规格
- (void)updataSupermarkProductWIthUNITID_ID:(NSString *)UNITID_ID andGoodModel:(ZJBLFMDBGoodsModel *)Model {
    
    //如果同一商品的同一规格存在
    if ([UNITID_ID isEqualToString:Model.UNITID_ID]) return;
    
    //删除
    [self deleteFromProductShopCarWithUNITID_ID:UNITID_ID];
    
    //如果同一商品的同一规格不存在 添加
    [self openDatabase]; //MAX_BUY_NUM
    
    NSString *insertSql = @"INSERT INTO GOODSLIST(UNITID_ID, USER_ID, GOODS_ID, UNIT_ID, GOODS_NAME, BUY_NUM, MAX_BUY_NUM, GOODS_IMG, STANDARD_NAMR, PRICE_RANGE, HOURSE_CODE,GOOD_CHECK,EDIT,EDIT_STATE,PROMOTION_ID,ISFULL_RE,ISSUP_VOU) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    [self.database executeUpdate:insertSql,Model.UNITID_ID, USER_ID, Model.GOODS_ID, Model.UNIT_ID,Model.GOODS_NAME, Model.BUY_NUM, Model.MAX_BUY_NUM, Model.GOODS_IMG, Model.STANDARD_NAMR, Model.PRICE_RANGE, Model.HOURSE_CODE, Model.GOOD_CHECK, Model.EDIT, Model.EDIT_STATE, Model.PROMOTION_ID, Model.ISFULL_RE, Model.ISSUP_VOU];
    
    //同步购买限制数据
    [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE GOODSLIST SET USE_SF='%@' ,START_SN='%@' ,CLASS_NUM='%@', DEL_MA='%@' WHERE HOURSE_CODE='%@' AND USER_ID = '%@'", Model.USE_SF, Model.START_SN,Model.CLASS_NUM,Model.DEL_MA, Model.HOURSE_CODE, USER_ID]];
    
    [self closeDatabase];
}


//采购页商品校验 --> 根据UNITID_ID 更改商品校验结果GOOD_CHECK
- (void)updataSupermarkProductWIthUNITID_ID:(NSString *)UNITID_ID andGOOD_CHECK:(NSString *)GOOD_CHECK {
    [self openDatabase];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE GOODSLIST SET GOOD_CHECK='%@'  WHERE UNITID_ID = '%@' AND USER_ID = '%@'", GOOD_CHECK, UNITID_ID, USER_ID];
    [self.database executeUpdate:updateSql];
    [self closeDatabase];
}


//////////////////////////////////    查     ///////////////////////////////////
#pragma mark - 根据 UNITID_ID 获取单个商品价格 -
- (NSString *)getGoodsSinglePriceWithUNITID_ID:(NSString *)UNITID_ID {
    
    [self openDatabase];
    NSString *sql = @"SELECT * FROM GOODSLIST WHERE UNITID_ID = ? AND USER_ID = ?";
    FMResultSet *set = [self.database executeQuery:sql,UNITID_ID, USER_ID];
    NSString *count;
    NSString *priceRange;
    while ([set next]) {
        count = [set stringForColumn:@"BUY_NUM"];
        priceRange = [set stringForColumn:@"PRICE_RANGE"];
    }
    [self closeDatabase];
    
    return [self getPriceFromPriceRange:priceRange withBuyCount:count];
}


//获取购买的单个商品规格的数量
- (NSInteger)getSupermarkProductBuyCountWithUNITID_ID:(NSString *)UNITID_ID {
    
    [self openDatabase];
    NSString *sql = @"SELECT * FROM GOODSLIST WHERE UNITID_ID = ? AND USER_ID = ?";
    FMResultSet *set = [self.database executeQuery:sql,UNITID_ID,USER_ID];
    NSString *count;
    while ([set next]) {
        count = [set stringForColumn:@"BUY_NUM"];
    }
    [self closeDatabase];
    return [count intValue];
}

//获取已经勾选商品的总数量
- (NSInteger)getAllGoodsNumber {
    
    [self openDatabase];
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE  USER_ID = '%@'",  USER_ID];
    
    FMResultSet *set = [self.database executeQuery:Sql];
    int count = 0;
    while ([set next]) {
        count += [[set stringForColumn:@"BUY_NUM"] intValue];
    }
    [self closeDatabase];
    return count;
}


- (NSInteger)getAllSelGoodsNumber {
    [self openDatabase];
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE  USER_ID = '%@' AND EDIT_STATE='%@' AND GOOD_CHECK='%@'", USER_ID, @"1", @"0"];
    
    FMResultSet *set = [self.database executeQuery:Sql];
    int count = 0;
    while ([set next]) {
        count += [[set stringForColumn:@"BUY_NUM"] intValue];
    }
    [self closeDatabase];
    return count;
}

//获取 所有 加入购物车 有问题商品 的 总数量
- (NSInteger)getAllQuestionGoodsNumber {
    [self openDatabase];
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE  USER_ID = '%@' AND GOOD_CHECK!='%@'", USER_ID, @"0"];
    
    FMResultSet *set = [self.database executeQuery:Sql];
    int count = 0;
    while ([set next]) {
        count += [[set stringForColumn:@"BUY_NUM"] intValue];
    }
    [self closeDatabase];
    return count;
}

//判断是否全部选中 有问题 商品 不计
- (BOOL)isSelectedAll {
    NSInteger AllCount = [self getAllGoodsNumber];
    NSInteger AllSelCount = [self getAllSelGoodsNumber];
    NSInteger AllQuestionCount = [self getAllQuestionGoodsNumber];
    return (AllCount != 0) && (AllCount == (AllSelCount + AllQuestionCount));
}

//获取已经勾选商品的总价格
- (double)getAllSelectGoodsTotalPrice {
    
    [self openDatabase];
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE EDIT_STATE='%@' AND USER_ID = '%@' AND GOOD_CHECK = '%@'", @"1", USER_ID,  @"0"];
    FMResultSet *set = [self.database executeQuery:Sql];
    double totlePrice = 0.00; //所有商品所有规格的总价钱
    
    while ([set next]) {
        double priceCount = 0.00; //每一规格价钱
        int SingleBuyCount = [[set stringForColumn:@"BUY_NUM"] intValue];
        double SinglePrice = [[self getPriceFromPriceRange:[set stringForColumn:@"PRICE_RANGE"] withBuyCount:[set stringForColumn:@"BUY_NUM"]] doubleValue];
        priceCount = SingleBuyCount * SinglePrice;
        totlePrice += priceCount;
    }
    [self closeDatabase];
    return totlePrice;
}


//点击结算时 获取所有选中的商品信息 且此商品有效 返回商品信息数组
- (NSArray *)getAllSelectGoods {
    
    [self openDatabase];
    NSMutableArray *arr = [NSMutableArray array];
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE EDIT_STATE='%@' AND USER_ID = '%@' AND GOOD_CHECK = '%@'", @"1", USER_ID, @"0"];
    
    FMResultSet *rs = [self.database executeQuery:Sql];
    while ([rs next]) {
        
        ZJBLFMDBGoodsModel *model = [[ZJBLFMDBGoodsModel alloc] init];
        model.UNIT_ID = [rs stringForColumn:@"UNIT_ID"];
        model.BUY_NUM = [rs stringForColumn:@"BUY_NUM"];
        model.PROMOTION_ID = [rs stringForColumn:@"PROMOTION_ID"];
        model.HOURSE_CODE = [rs stringForColumn:@"HOURSE_CODE"];
        
        [arr addObject:model];
    }
    [self closeDatabase];
    return arr;
}


#pragma mark - 获取所有的记录 -
- (NSMutableArray *)allGoods {
    
    [self openDatabase];
    NSMutableArray *arr = [NSMutableArray array];
    NSString *sql = @"SELECT * FROM GOODSLIST WHERE USER_ID = ?";
    
    FMResultSet *rs = [self.database executeQuery:sql,USER_ID];
    while ([rs next]) {
        ZJBLFMDBGoodsModel *model = [[ZJBLFMDBGoodsModel alloc] init];
        model.UNITID_ID = [rs stringForColumn:@"UNITID_ID"];
        model.GOODS_ID = [rs stringForColumn:@"GOODS_ID"] ;
        model.UNIT_ID = [rs stringForColumn:@"UNIT_ID"];
        model.GOODS_NAME = [rs stringForColumn:@"GOODS_NAME"];
        model.BUY_NUM = [rs stringForColumn:@"BUY_NUM"];
        model.MAX_BUY_NUM = [rs stringForColumn:@"MAX_BUY_NUM"];
        model.GOODS_IMG = [rs stringForColumn:@"GOODS_IMG"];
        model.STANDARD_NAMR = [rs stringForColumn:@"STANDARD_NAMR"];
        model.PRICE_RANGE = [rs stringForColumn:@"PRICE_RANGE"];
        model.HOURSE_CODE = [rs stringForColumn:@"HOURSE_CODE"];
        model.HOURSE_NAME = [rs stringForColumn:@"HOURSE_NAME"];
        model.GOOD_CHECK = [rs stringForColumn:@"GOOD_CHECK"];
        model.EDIT = [rs stringForColumn:@"EDIT"];
        model.EDIT_STATE = [rs stringForColumn:@"EDIT_STATE"];
        model.PROMOTION_ID = [rs stringForColumn:@"PROMOTION_ID"];
        model.ISFULL_RE = [rs stringForColumn:@"ISFULL_RE"] ;
        model.ISSUP_VOU = [rs stringForColumn:@"ISSUP_VOU"];
        model.MIN_NUM = [self getGoodsMinNumFromPriceRange:[rs stringForColumn:@"PRICE_RANGE"]];
        model.USE_SF = [rs stringForColumn:@"USE_SF"] ;
        model.START_SN = [rs stringForColumn:@"START_SN"] ;
        model.CLASS_NUM = [rs stringForColumn:@"CLASS_NUM"] ;
        model.DEL_MA = [rs stringForColumn:@"DEL_MA"] ;
        [arr addObject:model];
    }
    [self closeDatabase];
    return arr;
}

//是否存在某条记录
- (BOOL)isExist:(NSString *)UNITID_ID {
    
    [self openDatabase];
    int iCount = 0; //保存符合条件的结果集数目
    NSString *sql = @"SELECT COUNT(*) FROM GOODSLIST WHERE UNITID_ID = ?";
    FMResultSet *rs = [self.database executeQuery:sql,UNITID_ID];
    while ([rs next]) {
        
        iCount = [rs intForColumnIndex:0];
        break;
    }
    if (iCount > 0) {
        
        [self closeDatabase];
        return YES;
    }
    
    [self closeDatabase];
    return NO;
}



//////////////////////////////////    辅助方法     ///////////////////////////////////
//获取该规格商品下的最小数量
- (NSInteger)getGoodsMinNumFromPriceRange:(NSString *)priceRange {
    
    id json = [NSJSONSerialization JSONObjectWithData:[priceRange dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
    if ([json isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)json;
        NSDictionary *dict = [array firstObject];
        return [dict[@"num"] integerValue];
    }
    return 0;
}

//根据仓库代码查找查找当前仓库的所有商品
- (NSArray *)getSingleGroupAllGoodsWithHouseCode:(NSString *)HOURSE_CODE {
    
    [self openDatabase];
    NSMutableArray *arr = [NSMutableArray array];
    NSString *Sql = [NSString stringWithFormat:@"SELECT * FROM GOODSLIST WHERE HOURSE_CODE='%@' AND USER_ID = '%@'", HOURSE_CODE, USER_ID];
    
    FMResultSet *rs = [self.database executeQuery:Sql];
    while ([rs next]) {
        
        ZJBLFMDBGoodsModel *model = [[ZJBLFMDBGoodsModel alloc] init];
        model.EDIT_STATE = [rs stringForColumn:@"EDIT_STATE"];
        [arr addObject:model];
    }
    [self closeDatabase];
    return arr;
    
}


// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [self.database executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        //        NSLog(@"isTableOK %d", count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}


//根据某一规格的商品数量获取其价格
- (NSString *)getPriceFromPriceRange:(NSString *)priceRange withBuyCount:(NSString *)buyCount {
    
    id json = [NSJSONSerialization JSONObjectWithData:[priceRange dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
    if ([json isKindOfClass:[NSArray class]]) {
        
        NSArray *array = (NSArray*)json;
        
        NSUInteger arrayCount = array.count;  //获取价格梯度的个数
        NSUInteger count = [buyCount intValue]; //购买的商品数量
        
        if (arrayCount == 1) { //一个 价格 梯度
            NSDictionary *dict = array[0];
            return dict[@"price"];
        }
        
        if (arrayCount == 2) { //两个 价格 梯度
            
            NSDictionary *minDict = array[0];
            NSDictionary *maxDict = array[1];
            //第二个价格梯度 最大数量
            int maxCount = [maxDict[@"num"] intValue];
            
            if (count < maxCount) {
                return minDict[@"price"];
            }else {
                return maxDict[@"price"];
            }
        }else { //其他 价格 梯度 由于最多三个价格梯度  这里默认只取前三个价格梯度
            
            NSDictionary *minDict = array[0];
            NSDictionary *midDict = array[1];
            NSDictionary *maxDict = array[2];
            
            //第二个价格梯度 最大数量
            int midCount = [midDict[@"num"] intValue];
            //第二个价格梯度 最大数量
            int maxCount = [maxDict[@"num"] intValue];
            
            if (count < midCount) {
                return minDict[@"price"];
            }else if (count < maxCount) {
                return midDict[@"price"];
            }else  {
                return maxDict[@"price"];
            }
        }
    }
    return @"0.00";
}

@end


/*
 存储字段：
 
 主键(TEXT)               UNITID_ID;
 商品id(INTEGER)          GOODS_ID;
 商品规格id(INTEGER)       UNIT_ID;
 商品名称(VARCHAR(32))     GOODS_NAME;
 购买数量(INTEGER)         BUY_NUM ;
 最大购买数量(INTEGER)      MAX_BUY_NUM ;
 商品图片(VARCHAR(32))      GOODS_IMG ;
 规格名称(VARCHAR(32))      STANDARD_NAMR;
 商品价格区间(VARCHAR(32))   PRICE_RANGE;
 仓库代码(VARCHAR(32))      HOURSE_CODE;
 仓库名称(VARCHAR(32))      HOURSE_NAME;
 
 活动ID(INTEGER)            PROMOTION_ID;
 是否支持满减(INTEGER)        ISFULL_RE;
 是否支持提货券(INTEGER)      ISSUP_VOU;
 
 是否启用起送限制(INTEGER)     USE_SF
 起送数量(INTEGER)            START_SN
 起订种类(INTEGER)            CLASS_NUM
 起送金额(INTEGER)            DEL_MA
 
 
 ====================  辅助字段:  ===============================
 校验（如库存不足）(VARCHAR(32)) GOOD_CHECK;
 Table头部 编辑(INTEGER)       EDIT;
 Table Cell选中状态(INTEGER)   EDIT_STATE;
 
 */



