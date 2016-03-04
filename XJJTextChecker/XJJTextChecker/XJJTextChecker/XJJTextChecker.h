//
//  XJJTextChecker.h
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJJCheckedTextInfo.h"
#import "XJJCheckingResultInfo.h"
#import "XJJTextObject.h"

#import "UITextField+XJJTextChecker.h"

typedef void (^XJJTextCheckerErrorResultHandler)(XJJCheckingResultInfo *resultInfo);
typedef void (^XJJTextCheckerSuccessHandler)(XJJCheckingResultInfo *resultInfo);
typedef void (^XJJTextCheckerResultHandler)(XJJCheckingResultInfo *resultInfo);

@interface XJJTextChecker : NSObject

/**
 *  @author 蔚哥哥, 16-03-02 18:03:57
 *
 *  检查文本是否符合规则
 *
 *  @param objectList     被检查对象列表
 *  @param resultHandler  结果回调
 */
+ (void)checkWithTextObjectList:(NSArray<id<XJJTextObject>> *)objectList
                  resultHandler:(XJJTextCheckerResultHandler)resultHandler;

/**
 *  @author 蔚哥哥, 16-03-02 19:03:15
 *
 *  检查文本是否符合规则
 *
 *  @param objectList     被检查对象列表
 *  @param correctHandler 都正确时的回调
 *  @param errorHandler   出现错误时的回调
 */
+ (void)checkWithTextObjectList:(NSArray<id<XJJTextObject>> *)objectList
                 correctHandler:(XJJTextCheckerSuccessHandler)correctHandler
                   errorHandler:(XJJTextCheckerErrorResultHandler)errorHandler;

@end
