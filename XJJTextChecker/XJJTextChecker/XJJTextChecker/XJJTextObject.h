//
//  XJJTextObject.h
//  LJWTextChecker
//
//  Created by ljw on 16/3/2.
//  Copyright © 2016年 ljw. All rights reserved.
//

/******************************************************************************
 
 * 反正你保证在调用.checkedTextInfo的时候能取到值并且checkedText是你想要检查的text就好 *
 
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "XJJCheckedTextInfo.h"

@protocol XJJTextObject <NSObject>

/**
 *  @author 蔚哥哥, 16-03-02 21:03:19
 *
 *  检查文本信息
 */
@property (nonatomic, strong) XJJCheckedTextInfo *checkedTextInfo;

@end
