/*
 *  pinyin.h
 *  Chinese Pinyin First Letter
 *
 *  Created by 郭军 on 2017/3/14.
 *  Copyright © 2017年 ZJNY. All rights reserved.
 *
 */

/*
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *hanyu = @"中国共产党万岁！";
 * for (int i = 0; i < [hanyu length]; i++)
 * {
 *     printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
 * }
 *
 */

char pinyinFirstLetter(unsigned short hanzi);
