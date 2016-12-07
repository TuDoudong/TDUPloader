//
//  TDUploaderOperation.m
//  TDUPLoader
//
//  Created by 董慧翔 on 16/9/8.
//  Copyright © 2016年 TudouDong. All rights reserved.
//

#import "TDUploaderOperation.h"


@interface TDUploaderOperation ()<NSURLSessionDelegate>

@property (nonatomic,copy) TDUploaderProgressBlock progressBlock;
@property (nonatomic,copy) TDUploaderCompleteBlock completeBlock;
@property (nonatomic,copy) TDImageCallBackBlock cancelBlock;


@property (nonatomic,strong) NSURLSessionUploadTask *uploadTask;
@property (nonatomic,strong) NSURLSession *uploadSession;
@property (nonatomic,strong) NSMutableData *mutableData;


@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@property (atomic,strong) NSThread *thread;
@end

@implementation TDUploaderOperation
@synthesize executing = _executing;
@synthesize finished = _finished;


- (instancetype)initWithRequest:(NSURLRequest *)request
                        fileURL:(NSURL *)fileURL
                        options:(TDUpLoderOptions)options
                       progress:(TDUploaderProgressBlock)progressBlock
                      completed:(TDUploaderCompleteBlock)completeBlock
                         cancel:(TDImageCallBackBlock)cancelBlock{
    
    if (self = [super init]) {
        
        _options = options;
        _request = request;
        _fileURL = fileURL;
        _progressBlock = [progressBlock copy];
        _completeBlock = [completeBlock copy];
        _cancelBlock = [cancelBlock copy];
        
        
        _finished = NO;
        _executing = NO;
        
    }
    
    
    return self;
    
}

- (void)start{
    @synchronized (self) {
        
        if (self.isCancelled) {
            self.finished = YES;
            [self reset];
            return;
        }
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.uploadSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
        self.uploadTask = [self.uploadSession uploadTaskWithRequest:_request fromFile:_fileURL];
        self.executing = YES;
        self.thread = [NSThread currentThread];
    }

    [self.uploadTask resume];
    [self.uploadSession finishTasksAndInvalidate];
    
    if (self.uploadTask) {
        if (self.progressBlock) {
            self.progressBlock(0, NSURLResponseUnknownLength);
        }
        
        CFRunLoopRun();
        
        if (!self.isFinished) {
            [self.uploadTask cancel];
            
            
            [self URLSession:self.uploadSession task:self.uploadTask didCompleteWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:@{NSURLErrorFailingURLErrorKey : self.request.URL}]];
            
        }
        
    }else{
        if (self.completeBlock) {
            self.completeBlock(nil, nil, [NSError errorWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : @"Connection can't be initialized"}], YES);
        }
    }

    
}


- (void)reset {
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
}


























@end
