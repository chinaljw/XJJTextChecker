//
//  UITextField+XJJTextChecker.h
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJJTextObject.h"

@interface UITextField (XJJTextChecker) <XJJTextObject>

@property (nonatomic, strong) XJJCheckedTextInfo *checkedTextInfo;

@end
