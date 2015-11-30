//
//  KGSquareViewController.h
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KGSquareRequest.h"
#import "MJRefresh.h"
#import "KxMenu.h"


@interface KGSquareViewController : UIViewController <KGSquareRequestDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *pic_id;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *locationDic;

- (void)toCheckPicture;

@end
