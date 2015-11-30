//
//  BLMultipartForm.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 一般情况下，协议文档（API）规定的以POST方式请求服务器的时候，向服务器发送的数据一般以表单的形式作为HTTP的Body提交。本类封装了如果将要发送的数据转换为表单。
 */

@interface BLMultipartForm : NSObject {
    NSMutableArray	*_fields;
    NSString		*_boundaryString;
}

- (void)addValue:(id)value forField:(NSString *)field;
- (NSData *)httpBody;
- (NSData *)httpBodyForImage;
- (NSString *)boundary;
- (NSString *)contentType;

- (NSString *)getRandomBoundary;

@end

