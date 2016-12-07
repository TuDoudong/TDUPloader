//
//  TDUploaderOperation.h
//  TDUPLoader
//
//  Created by 董慧翔 on 16/9/8.
//  Copyright © 2016年 TudouDong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDUploaderHandle.h"
@interface TDUploaderOperation : NSOperation

@property (assign, nonatomic, readonly) TDUpLoderOptions options;
@property (strong, nonatomic, readonly) NSURLRequest *request;
@property (strong, nonatomic, readonly) NSURL *fileURL;

- (instancetype)initWithRequest:(NSURLRequest *)request
                        fileURL:(NSURL *)fileURL
                        options:(TDUpLoderOptions)options
                       progress:(TDUploaderProgressBlock)progressBlock
                      completed:(TDUploaderCompleteBlock)completeBlock
                         cancel:(TDImageCallBackBlock)cancelBlock;

@end
