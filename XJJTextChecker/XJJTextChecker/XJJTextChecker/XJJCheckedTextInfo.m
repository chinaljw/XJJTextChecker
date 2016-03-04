//
//  XJJCheckedTextInfo.m
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import "XJJCheckedTextInfo.h"

#pragma mark - 正则表达式集合 -
static NSString *const kRegStringPhoneNumber = @"^[1][3-8]\\d{9}$";
static NSString *const kRegStringPassword = @"^[a-zA-z0-9]{6}[a-zA-z0-9]{0,10}$";
static NSString *const kRegStringCaptchaCode = @"^[0-9]\\d{5}$";
static NSString *const kRegStringCarNumber = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$";
static NSString *const kRegStringChineseName = @"^[\u4E00-\u9FA5]{2,5}$";
static NSString *const kRegStringEmail = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$";

static NSString *const kRegStringAll = @"[\\s\\S]*";

static NSDictionary<NSString *, NSString *> * DefaultRegMap;
static NSDictionary<NSString *, NSString *> * DefaultErrorDesMap;
static NSDictionary<NSString *, NSString *> * DefaultEmptyDesMap;


@implementation XJJCheckedTextInfo

+ (void)initialize
{
    
    
    NSArray *typeKeyList = @[
                         @(XJJCheckedTextInfoTypePhoneNumber).description,
                         @(XJJCheckedTextInfoTypePassword).description,
                         @(XJJCheckedTextInfoTypeCaptcha).description,
                         @(XJJCheckedTextInfoTypeEmail).description,
                         @(XJJCheckedTextInfoTypeCarNumber).description,
                         @(XJJCheckedTextInfoTypeChineseName).description,
                         ];
    
    NSArray *regList = @[
                         kRegStringPhoneNumber,
                         kRegStringPassword,
                         kRegStringCaptchaCode,
                         kRegStringEmail,
                         kRegStringCarNumber,
                         kRegStringChineseName,
                         ];
    
    NSArray *name = @[
                      @"手机号",
                      @"密码",
                      @"验证码",
                      @"邮箱格",
                      @"车牌格",
                      @"名字格",
                      ];
    
    NSString *errorString = @"格式不正确";
    NSString *emptyString = @"不能为空";
    
    NSMutableDictionary<NSString *, NSString*> *regDic = [[NSMutableDictionary<NSString *, NSString *> alloc] init];
    NSMutableDictionary<NSString *, NSString*> *errorDic = [[NSMutableDictionary<NSString *, NSString *> alloc] init];
    NSMutableDictionary<NSString *, NSString*> *emptyDic = [[NSMutableDictionary<NSString *, NSString *> alloc] init];
    
    [typeKeyList enumerateObjectsUsingBlock:^(NSString *  _Nonnull typeKey, NSUInteger index, BOOL * _Nonnull stop) {
        
        [regDic setValue:regList[index] forKey:typeKey];
        [errorDic setValue:[name[index] stringByAppendingString:errorString] forKey:typeKey];
        [emptyDic setValue:[name[index] stringByAppendingString:emptyString] forKey:typeKey];
        
    }];
    
    DefaultRegMap = regDic;
    DefaultErrorDesMap = errorDic;
    DefaultEmptyDesMap = emptyDic;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allowEmpty = NO;
    }
    return self;
}

#pragma mark - Setter & Getter
- (NSDictionary<NSString *,NSString *> *)regStrings
{
    if (!_regStrings) {
        return DefaultRegMap;
    }
    return _regStrings;
}

- (NSDictionary<NSString *,NSString *> *)errorDescriptions
{
    if (!_errorDescriptions) {
        return DefaultErrorDesMap;
    }
    return _errorDescriptions;
}

- (NSDictionary<NSString *,NSString *> *)emptyDescriptions
{
    if (!_emptyDescriptions) {
        return DefaultEmptyDesMap;
    }
    return _emptyDescriptions;
}

#pragma mark - Public
- (NSString *)errorDescription
{
    if (self.typeList) {
        return self.customErrorDescription;
    }
    return self.errorDescriptions[@(self.type).description];
}

- (NSString *)emptyDescription
{
    
    if (self.typeList) {
        return self.customEmptyDescriptions;
    }
    
    return self.emptyDescriptions[@(self.type).description];
}

/**
 *  @author 蔚哥哥, 16-03-03 17:03:56
 *
 *  通过 XJJCheckedTextInfoType 获取相应的正则表达式
 *
 *  @param type XJJCheckedTextInfoType
 *
 *  @return 正则表达式
 */
- (NSString *)regStringWithCheckedTextInfoType:(XJJCheckedTextInfoType)type
{
    if (type == XJJCheckedTextInfoTypeCustom) {
        return self.customRegString ? : kRegStringAll;
    }
    else
    {
        return self.regStrings[@(self.type).description];
    }
}

@end
