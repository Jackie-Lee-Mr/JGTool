//
//  ZJBLFMDBTable.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/25.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLFMDBTable.h"

@interface ZJBLFMDBTable () {
    FMDatabase *database;
}

@end

@implementation ZJBLFMDBTable

//获取该类的单例
+ (ZJBLFMDBTable *)sharedTables {
    
    static ZJBLFMDBTable *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}
//实现父类的初始化，调用创建数据库
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [ZJBLFMDBTable sharedTables];
}

//实现父类的初始化方法，调用创建数据库
- (instancetype)init {
    if (self = [super init]) {
        [self createDataBase];
    }
    return self;
}

//创建数据库
- (void)createDataBase {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"mygoods.db"];
    
    database = [FMDatabase databaseWithPath:dbPath];
    
    JGLog(@"%@",dbPath);
    
    [database open];
    
    [self createTables];
}

//创建数据表
- (void)createTables {
    
//    if ([self isTableOK:@"GOODS"]) {
//        [self eraseTable:@"GOODS"];
//    }
    
    //创建表的sql
    NSString *sql = @"CREATE TABLE IF NOT EXISTS GOODSLIST(UNITID_ID TEXT PRIMARY KEY, USER_ID INTEGER,GOODS_ID INTEGER, UNIT_ID INTEGER,GOODS_NAME VARCHAR(32),BUY_NUM INTEGER, MAX_BUY_NUM INTEGER, GOODS_IMG VARCHAR(32),STANDARD_NAMR VARCHAR(32),PRICE_RANGE VARCHAR(32),HOURSE_CODE VARCHAR(32),HOURSE_NAME VARCHAR(32),PROMOTION_ID INTEGER,ISFULL_RE INTEGER,ISSUP_VOU INTEGER,USE_SF INTEGER,START_SN INTEGER,CLASS_NUM INTEGER,DEL_MA INTEGER,GOOD_CHECK VARCHAR(32),EDIT INTEGER,EDIT_STATE INTEGER)";

    //这个方法executeUpdate可以增删改创操作 通过这个方法执行字符串保存的sql语句，返回类型Bool 如果为真代表创建成功 否则创建失败
    [database executeUpdate:sql];
}


// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [database executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
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


//// 删除表
//- (BOOL) deleteTable:(NSString *)tableName
//{
//    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
//    if (![database executeUpdate:sqlstr])
//    {
//        JGLog(@"Delete table error!");
//        return NO;
//    }
//    return YES;
//}



// 清除表数据
//注意:使用[database executeUpdate:@"DROP TABLE IF EXISTS tableName;"];删除表操作不成功???
- (BOOL) eraseTable:(NSString *)tableName
{
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    if (![database executeUpdate:sqlstr])
    {
//        JGLog(@"Erase table error!");
        return NO;
    }
    return YES;
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
 是否支持提货券(INTEGER)       ISSUP_VOU;
 
 是否启用起送限制(INTEGER)     USE_SF
 起送数量(INTEGER)            START_SN
 起订种类(INTEGER)            CLASS_NUM
 起送金额(INTEGER)            DEL_MA
 
 
 ====================  辅助字段:  ===============================
 校验（如库存不足）(VARCHAR(32))GOOD_CHECK;
 Table头部 编辑()EDIT;
 Table Cell选中状态()EDIT_STATE;
 */






