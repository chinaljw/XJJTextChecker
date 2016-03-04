//
//  XJJCheckedTextInfo.h
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author 蔚哥哥, 16-03-02 20:03:49
 *
 *  info的类型
 */
typedef NS_OPTIONS(NSUInteger, XJJCheckedTextInfoType) {
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:09
     *
     *  自定义
     */
    XJJCheckedTextInfoTypeCustom = 0,
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:49
     *
     *  电话号码
     */
    XJJCheckedTextInfoTypePhoneNumber,
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:49
     *
     *  密码
     */
    XJJCheckedTextInfoTypePassword,
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:49
     *
     *  验证码
     */
    XJJCheckedTextInfoTypeCaptcha,
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:49
     *
     *  邮箱
     */
    XJJCheckedTextInfoTypeEmail,
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:49
     *
     *  车牌
     */
    XJJCheckedTextInfoTypeCarNumber,
    /**
     *  @author 蔚哥哥, 16-03-02 20:03:49
     *  
     *  中文名
     */
    XJJCheckedTextInfoTypeChineseName,
};

@interface XJJCheckedTextInfo : NSObject

/**
 *  @author 蔚哥哥, 16-03-02 20:03:52
 *
 *  TextInfo的类型
 */
@property (nonatomic, assign) XJJCheckedTextInfoType type;

/**
 *  @author 蔚哥哥, 16-03-03 17:03:44
 *
 *  当type为XJJCheckedTextInfoTypeCustom时，将会使用此属性作为正则规则
 */
@property (nonatomic, copy) NSString *customRegString;

/**
 *  @author 蔚哥哥, 16-03-02 18:03:13
 *
 *  type列表(元素为 XJJCheckedTextInfoType 的NSNumber对象数组）当typeLists不为空时 TextChecker 会采用typeLists里的type 而不是type
 */
@property (nonatomic, strong) NSArray<NSNumber *> *typeList;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:21
 *
 *  格式不正确时的描述和对应XJJCheckedTextInfoType的映射,key为@(XJJCheckedTextInfoType).description
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *errorDescriptions;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:21
 *
 *  当为空时的描述和对应XJJCheckedTextInfoType的映射,key为@(XJJCheckedTextInfoType).description
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *emptyDescriptions;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:35
 *
 *  待检查的文本
 */
@property (nonatomic, copy) NSString *checkedText;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:21
 *
 *  正则表达式和对应XJJCheckedTextInfoType的映射,key为@(XJJCheckedTextInfoType).description
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *regStrings;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:10
 *
 *  是否允许为空
 */
@property (nonatomic, assign) BOOL allowEmpty;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:46
 *
 *  要比较的textInfo
 */
@property (nonatomic, weak) XJJCheckedTextInfo *comparedTextInfo;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:59
 *
 *  不一样时的描述，当comparedTextInfo不为空时切比较结果为不一样时会用到
 */
@property (nonatomic, copy) NSString *unlikeDescription;

/**
 *  @author 蔚哥哥, 16-03-02 19:03:17
 *
 *  当type类型不止一个即typeList不为空的时候会用到（请一并设置）
 */
@property (nonatomic, copy) NSString *customErrorDescription;

/**
 *  @author 蔚哥哥, 16-03-02 19:03:51
 *
 *  当type类型不止一个即typeList不为空的时候会用到（请一并设置）
 */
@property (nonatomic, copy) NSString *customEmptyDescriptions;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:42
 *
 *  获取验证结果为错误时的描述
 *
 *  @return 描述
 */
- (NSString *)errorDescription;

/**
 *  @author 蔚哥哥, 16-03-02 20:03:42
 *
 *  获取验证结果为空时的描述
 *
 *  @return 描述
 */
- (NSString *)emptyDescription;

/**
 *  @author 蔚哥哥, 16-03-03 17:03:56
 *
 *  通过 XJJCheckedTextInfoType 获取相应的正则表达式
 *
 *  @param type XJJCheckedTextInfoType
 *
 *  @return 正则表达式
 */
- (NSString *)regStringWithCheckedTextInfoType:(XJJCheckedTextInfoType)type;

@end
