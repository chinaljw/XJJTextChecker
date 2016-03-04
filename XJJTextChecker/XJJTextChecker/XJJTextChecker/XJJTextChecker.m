//
//  XJJTextChecker.m
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import "XJJTextChecker.h"


@implementation XJJTextChecker

/**
 *  正则验证
 *
 *  @param text      需验证文本
 *  @param regString 正则表达式
 *
 *  @return 是否匹配
 */
+ (BOOL)customRegularCheckWithText:(NSString *)text andRegString:(NSString *)regString
{
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSTextCheckingResult *result = [expression firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
    
    return !NSEqualRanges(result.range, NSMakeRange(0, 0));
}

/**
 *  @author 蔚哥哥, 16-03-02 21:03:05
 *
 *  验证正则表达式
 *
 *  @param object XJJTextObject
 *
 *  @return 验证结果
 */
+ (XJJCheckingResultInfo *)checkTextObjectByReg:(id<XJJTextObject>)object
{
    XJJCheckingResultInfo *result = [[XJJCheckingResultInfo alloc] init];
    XJJCheckedTextInfo *checkedInfo = [object checkedTextInfo];
    result.checkedInfo = checkedInfo;
    
    if (checkedInfo.typeList.count) {
        for (NSNumber *typeNumber in checkedInfo.typeList) {
            XJJCheckedTextInfoType type = typeNumber.unsignedIntegerValue;
            NSString *regString = [checkedInfo regStringWithCheckedTextInfoType:type];
            BOOL isCorrect = [self customRegularCheckWithText:[object checkedTextInfo].checkedText andRegString:regString];
            if (isCorrect) {
                result.resultType = XJJTextCheckingResultInfoTypeCorrect;
                return result;
            }
        }
        result.resultType = XJJTextCheckingResultInfoTypeFormatError;
        result.resultDescription = [checkedInfo errorDescription];
    }
    else
    {
        NSString *regString = [checkedInfo regStringWithCheckedTextInfoType:checkedInfo.type];
        result.resultType = [self customRegularCheckWithText:[object checkedTextInfo].checkedText andRegString:regString] ? XJJTextCheckingResultInfoTypeCorrect : XJJTextCheckingResultInfoTypeFormatError;
        result.resultDescription = [checkedInfo errorDescription];
    }
    
    return result;
}

/**
 *  @author 蔚哥哥, 16-03-02 21:03:42
 *
 *  检查是否为空
 *
 *  @param object XJJTextObject
 *
 *  @return 检查结果
 */
+ (XJJCheckingResultInfo *)checkIsEmptyWithTextObject:(id<XJJTextObject>)object
{
    
    XJJCheckingResultInfo *result = [[XJJCheckingResultInfo alloc] init];
    XJJCheckedTextInfo *checkedInfo = [object checkedTextInfo];
    result.checkedInfo = checkedInfo;
    result.resultType = object.checkedTextInfo.checkedText.length > 0 ? XJJTextCheckingResultInfoTypeCorrect : XJJTextCheckingResultInfoTypeEmpty;
    result.resultDescription = [checkedInfo emptyDescription];
    
    return result;
}

/**
 *  @author 蔚哥哥, 16-03-02 21:03:58
 *
 *  比较两object和它的compareobject是否相等
 *
 *  @param object XJJTextObject
 *
 *  @return 结果
 */
+ (XJJCheckingResultInfo *)compareTextObject:(id<XJJTextObject>)object
{
    XJJCheckingResultInfo *result = [[XJJCheckingResultInfo alloc] init];
    
    XJJCheckedTextInfo *checkedInfo = [object checkedTextInfo];
    
    if (!checkedInfo.comparedTextInfo) {
        result.resultType = XJJTextCheckingResultInfoTypeCorrect;
        return result;
    }
    
    result.checkedInfo = checkedInfo;
    
    result.resultType = [checkedInfo.checkedText isEqualToString:checkedInfo.comparedTextInfo.checkedText] ? XJJTextCheckingResultInfoTypeCorrect : XJJTextCheckingResultInfoTypeUnlike;
    result.resultDescription = checkedInfo.unlikeDescription;
    
    return result;
}

/**
 *  @author 蔚哥哥, 16-03-02 18:03:57
 *
 *  检查文本是否符合规则
 *
 *  @param objectList     被检查对象列表
 *  @param resultHandler  结果回调
 */
+ (void)checkWithTextObjectList:(NSArray<id<XJJTextObject>> *)objectList
                  resultHandler:(XJJTextCheckerResultHandler)resultHandler
{
    
    XJJCheckingResultInfo *result = nil;
    
    for (id<XJJTextObject> object in objectList) {
        
        result = [self checkIsEmptyWithTextObject:object];
        
        if ([object checkedTextInfo].allowEmpty && result.resultType != XJJTextCheckingResultInfoTypeCorrect) {
            continue;
        }
        else
        {
            if (result.resultType == XJJTextCheckingResultInfoTypeCorrect) {
                
                result = [self checkTextObjectByReg:object];
                
                if (result.resultType == XJJTextCheckingResultInfoTypeCorrect) {
                    
                    result = [self compareTextObject:object];
                    
                    if (result.resultType == XJJTextCheckingResultInfoTypeCorrect) {
                        continue;
                    }
                    
                    if (resultHandler) {
                        resultHandler(result);
                        return;
                    }
                    
                }
                
                if (resultHandler) {
                    resultHandler(result);
                    return;
                }
                
            }
            
            if (resultHandler) {
                resultHandler(result);
                return;
            }
        }
        
    }
    
    result = [[XJJCheckingResultInfo alloc] init];
    result.resultType = XJJTextCheckingResultInfoTypeEeverythingIsOK;
    
    if (resultHandler) {
        resultHandler(result);
        return;
    }
    
}

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
                   errorHandler:(XJJTextCheckerErrorResultHandler)errorHandler
{
    [self checkWithTextObjectList:objectList resultHandler:^(XJJCheckingResultInfo *resultInfo) {
        
        if (resultInfo.resultType == XJJTextCheckingResultInfoTypeEeverythingIsOK) {
            correctHandler(resultInfo);
        }
        else
        {
            errorHandler(resultInfo);
        }
        
    }];
}

@end
