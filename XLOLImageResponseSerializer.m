//
//  XLOLImageResponseSerializer.m
//  AF+OLImage
//
//  Created by 王凯 on 14-5-23.
//  Copyright (c) 2014年 王凯. All rights reserved.
//

#import "XLOLImageResponseSerializer.h"

@implementation XLOLImageResponseSerializer

+ (instancetype)sharedSerializer
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    Class OLImageClass = NSClassFromString(@"OLImage");
    if(![self isGIFData:data] || !OLImageClass){
        return [super responseObjectForResponse:response data:data error:error];
    }
    return [[OLImageClass alloc] initWithData:data scale:self.imageScale];
}

- (BOOL)isGIFData:(NSData *)data
{
    static Byte GIFType[] = {'G', 'I', 'F'};
    for (int i = 0; i < 3; ++i) {
        if (((Byte *)data.bytes)[i] != GIFType[i]) {
            return NO;
        }
    }
    return YES;
}

@end
