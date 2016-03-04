//
//  XJJCheckingResultInfo.h
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJJCheckedTextInfo.h"

/**
 *  @author 蔚哥哥, 16-03-02 21:03:39
 *
 *  检查结果枚举
 */
typedef NS_ENUM(NSInteger, XJJTextCheckingResultInfoType) {
    /**
     *  @author 蔚哥哥, 16-03-02 21:03:39
     *
     *  正确
     */
    XJJTextCheckingResultInfoTypeCorrect = 0,
    /**
     *  @author 蔚哥哥, 16-03-02 21:03:39
     *
     *  空
     */
    XJJTextCheckingResultInfoTypeEmpty = 1,
    /**
     *  @author 蔚哥哥, 16-03-02 21:03:39
     *
     *  格式错误
     */
    XJJTextCheckingResultInfoTypeFormatError = 2,
    /**
     *  @author 蔚哥哥, 16-03-02 21:03:39
     *
     *  不一样
     */
    XJJTextCheckingResultInfoTypeUnlike = 3,
    /**
     *  @author 蔚哥哥, 16-03-02 21:03:39
     *  
     *  都对了哟
     */
    XJJTextCheckingResultInfoTypeEeverythingIsOK = -1,
};

@interface XJJCheckingResultInfo : NSObject

/**
 *  @author 蔚哥哥, 16-03-02 21:03:39
 *
 *  出事的checkedInfo，如果对了的话它应该是nil
 */
@property (nonatomic, strong) XJJCheckedTextInfo *checkedInfo;

/**
 *  @author 蔚哥哥, 16-03-02 21:03:35
 *
 *  结果枚举
 */
@property (nonatomic, assign) XJJTextCheckingResultInfoType resultType;

/**
 *  @author 蔚哥哥, 16-03-02 21:03:41
 *
 *  结果描述
 */
@property (nonatomic, copy) NSString *resultDescription;

@end
