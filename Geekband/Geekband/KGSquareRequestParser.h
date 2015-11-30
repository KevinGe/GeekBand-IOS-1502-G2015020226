//
//  KGSquareRequestParser.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGSquareRequestParser : NSObject

@property (nonatomic, strong)NSMutableArray *addrArray;
@property (nonatomic, strong)NSMutableArray *pictureArrary;

- (NSDictionary *)parseJson:(NSData *)data;

@end
