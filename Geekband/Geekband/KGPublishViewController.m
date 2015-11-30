//
//  KGPublishViewController.m
//  Geekband
//
//  Created by sleepinge on 15/11/30.
//  Copyright © 2015年 sleepinge. All rights reserved.
//


#import "KGPublishViewController.h"
#import "KGPublishRequest.h"
#import "KGGlobal.h"
#import "KGPublishCell.h"
#import "AppDelegate.h"
#import "KGLocationParser.h"

@interface KGPublishViewController () <KGPublishRequestDelegate> {
    UILabel *titleLabel;
    BOOL locationOrNot;
    BOOL openTableViewOrNot;
}

@end

@implementation KGPublishViewController

- (void)makePulishButton {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, 0, 50, 40)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.alpha = 0.8;
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishPhotoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3.0;
    button.clipsToBounds = YES;
    [self.navigationController.navigationBar addSubview:button];
}

- (void)makeBackButton {
    UIButton *backButton = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(backButtonClicked:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonClicked:(id)sender {
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)getLatitudeAndLongitude {
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = 1000.0f;
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
                                                       message:@"定位失败"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations[0];
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitude = location.coordinate.longitude;
    
    self.dic = [NSMutableDictionary dictionary];
    NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
    [self.dic setValue:latitudeString forKey:@"latitude"];
    [self.dic setValue:longitudeString forKey:@"longitude"];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            // TODO:
            self.locationButton.titleLabel.text = dict[@"Name"];
            
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    [manager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.dic = [NSMutableDictionary dictionary];
    NSString *latitudeString = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.dic setValue:latitudeString forKey:@"latitude"];
    [self.dic setValue:longitudeString forKey:@"longitude"];
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            // TODO:
            self.locationButton.titleLabel.text = dict[@"Name"];
            
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)makeLocation {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *latitude = [NSString stringWithFormat:@"l=%@", [self.dic valueForKey:@"latitude"]];
        NSString *latitudeWithComma = [latitude stringByAppendingString:@"%2C"];
        NSString *args =[NSString stringWithFormat:@"%@%@", latitudeWithComma, [self.dic valueForKey:@"longitude"]];
        NSString *url = @"http://apis.baidu.com/3023/geo/address";
        [self request:url withHTTPArgs:args];
    }];
    
    [queue addOperation:operation];
}

//c5ee8b689b6ede2a9db717cc04ca48d5
- (void)request:(NSString *)httpURL withHTTPArgs:(NSString *)httpArgs {
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@?%@", httpURL, httpArgs];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
    request.HTTPMethod = @"GET";
    [request addValue:@"c5ee8b689b6ede2a9db717cc04ca48d5" forHTTPHeaderField:@"apikey"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         if (connectionError) {
             NSLog(@"HTTP Error: %@%ld", connectionError.localizedDescription, connectionError.code);
             // TODO:
             openTableViewOrNot = NO;
             
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"获取地理信息失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
         } else {
             NSInteger *responseCode = [(NSHTTPURLResponse *)response statusCode];
             NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             // TODO:
             openTableViewOrNot = YES;
             
             self.locationModel = [[KGLocationModel alloc]init];
             KGLocationParser *parser = [[KGLocationParser alloc]init];
             self.locationModel = [parser parseJson:data];
             [self makeTableView];
         }
     }];
}

- (void)publishPhotoButtonClicked {
    if ([self.textView.text isEqualToString:@"你想说的话"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"请写上你的留言"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
    } else {
        NSData *data = UIImageJPEGRepresentation(self.photoView.image, 0.00001);
        KGUserModel *user = [KGGlobal shareGlobal].user;
        KGPublishRequest *request = [[KGPublishRequest alloc]init];
        [request sendPublishRequestWithUserId:user.userId
                                        token:user.token
                                    longitude:[self.dic valueForKey:@"longitude"]
                                     latitude:[self.dic valueForKey:@"latitude"]
                                        title:self.textView.text
                                         data:data
                                     location:self.locationButton.titleLabel.text
                                     delegate:self];
    }
}

-(void)requestSuccess:(KGPublishRequest *)request picId:(NSString *)picId {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestFailed:(KGPublishRequest *)request error:(NSError *)error {
    NSLog(@"Error: sendPublishRequestWithUserId: %@", error);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}


- (void)makeTableView {
    CGFloat selfWidth = self.view.frame.size.width;
    CGFloat selfHeight = self.view.frame.size.height;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, selfHeight, selfWidth, 230) style:UITableViewStylePlain];
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setSeparatorColor: [UIColor blackColor]];
        [self.tableView setShowsVerticalScrollIndicator:YES];
        [self.tableView setShowsHorizontalScrollIndicator:NO];
        [self.tableView registerNib:[UINib nibWithNibName:@"KGPublishCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"publishCell"];
        [self.view addSubview:self.tableView];
        openTableViewOrNot = NO;
    }
    
    if (openTableViewOrNot == NO) {
        _blackView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight-230)];
        [_blackView addTarget:self action:@selector(blackViewTouchDown) forControlEvents:UIControlEventTouchDown];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0;
        [self.view addSubview:_blackView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.tableView setFrame:CGRectMake(0, selfHeight-230, selfWidth, 230)];
            _blackView.alpha = 0.5;
        }];
        openTableViewOrNot = YES;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.tableView setFrame:CGRectMake(0, selfHeight, selfWidth, 230)];
            _blackView.alpha = 0;
        }];
        [_blackView removeFromSuperview];
        openTableViewOrNot = NO;
    }
}

- (void)blackViewTouchDown {
    if (openTableViewOrNot == YES) {
        [self makeTableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationModel ? self.locationModel.nameArray.count - 1 : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KGPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publishCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    if (self.locationModel) {
        cell.nameLabel.text = self.locationModel.nameArray[indexPath.row];
        cell.placeLabel.text = self.locationModel.addrArray[indexPath.row];
    } else {
        cell.nameLabel.text = @"上海";
        cell.placeLabel.text = @"上海浦东国际金融中心";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.locationModel.addrArray.count > indexPath.row && self.locationModel.nameArray.count > indexPath.row) {
        NSString *locationString =  [NSString stringWithFormat:@"@%, %@", self.locationModel.nameArray[indexPath.row],
                                     self.locationModel.addrArray[indexPath.row]];
        self.locationButton.titleLabel.text = locationString;
        
    }
    
    if (openTableViewOrNot == YES) {
        [self makeTableView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 25) {
        [self.textView resignFirstResponder];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/25", textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"你想说的话"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = @"我想说的话";
    }
}

- (IBAction)locationButtonClicked:(id)sender {
    [self makeLocation];
    //    [self makeTableView];
}

- (void)touchDown:(id)sender {
    [self.textView resignFirstResponder];
    [self makeTableView];
}

- (IBAction)returnToCamera:(id)sender {
    [self showPhotoPickerOptions];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.pickerController = [[UIImagePickerController alloc]init];
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing = NO;
            self.pickerController.delegate = self;
            [self.navigationController presentViewController:self.pickerController animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
                                                           message:@"无法获取照相机"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            return;
        }
    } else if (buttonIndex == 1) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate = self;
        [self.navigationController presentViewController:self.pickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    CGSize imageSize = image.size;
    //    imageSize.height = 625;
    //    imageSize.width = 413;
    //    image = [self imageWithImage:image scaleToSize:imageSize];
    
    
    //    self.headImageView.image = image;
    self.photoView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)showPhotoPickerOptions {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [[UIColor alloc]initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc]initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    [self.navigationController.navigationBar setAlpha:1.0];
    self.textView.delegate = self;
    
    //title label
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30)];
    titleLabel.text = @"发布照片";
    titleLabel.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:titleLabel];
    
    [self makePulishButton];
    [self makeBackButton];
    
    [self getLatitudeAndLongitude];
    
    [self showPhotoPickerOptions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
