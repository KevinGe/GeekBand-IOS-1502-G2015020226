//
//  KGSquareRequestParser.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import "KGSquareRequestParser.h"
#import "KGSquareModel.h"
#import "KGPictureModel.h"

@implementation KGSquareRequestParser

-(NSDictionary *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (error) {
        NSLog(@"KGSquareRequestParser does not work.");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id data = [[jsonDic valueForKey:@"data"] allValues];
            
            KGSquareRequestParser *weakSelf = self;
            
            for (id dic in data) {
                weakSelf.addrArray = [NSMutableArray array];
                weakSelf.pictureArrary = [NSMutableArray array];
                KGSquareModel *squareModel = [[KGSquareModel alloc]init];
                [squareModel setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDict in dic[@"pic"]) {
                    KGPictureModel *picModel = [[KGPictureModel alloc]init];
                    [picModel setValuesForKeysWithDictionary:picDict];
                    [weakSelf.pictureArrary addObject:picModel];
                }
                [weakSelf.addrArray addObject:squareModel];
                [dictionary setObject:_pictureArrary forKey:_addrArray];
            }
        }
    }
    return dictionary;
}

@end