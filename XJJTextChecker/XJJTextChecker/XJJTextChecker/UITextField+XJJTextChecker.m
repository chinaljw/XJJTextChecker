//
//  UITextField+XJJTextChecker.m
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import "UITextField+XJJTextChecker.h"
#import <objc/runtime.h>

@implementation UITextField (XJJTextChecker)

#pragma mark - Setter & Getter
- (XJJCheckedTextInfo *)checkedTextInfo
{
    XJJCheckedTextInfo *checkTextInfo = objc_getAssociatedObject(self, _cmd);
    if (!checkTextInfo) {
        
        checkTextInfo = [[XJJCheckedTextInfo alloc] init];
        
        self.checkedTextInfo = checkTextInfo;
        
    }
    
    //在此赋值要验证的text
    checkTextInfo.checkedText = self.text;
    
    return checkTextInfo;
}

- (void)setCheckedTextInfo:(XJJCheckedTextInfo *)checkedTextInfo
{
    objc_setAssociatedObject(self, @selector(checkedTextInfo), checkedTextInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
