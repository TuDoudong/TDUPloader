//
//  TDUploaderHandle.h
//  TDUPLoader
//
//  Created by 董慧翔 on 16/9/8.
//  Copyright © 2016年 TudouDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TDUpLoderOptions) {
    TDUpLoderOptionsDefalt = 1 << 0,
    TDUpLoderOptionsBackground = 1 << 1,
};

typedef void(^TDUploaderProgressBlock)(NSInteger receivedSize,NSInteger expectedSize);
typedef void(^TDUploaderCompleteBlock)(UIImage *image, NSData *data, NSError *error, BOOL isfinished);

typedef void(^TDImageCallBackBlock)();

@interface TDUploaderHandle : NSObject

@end
