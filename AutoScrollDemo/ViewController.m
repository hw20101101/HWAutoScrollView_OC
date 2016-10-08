//
//  ViewController.m
//  AutoScrollDemo
//
//  Created by hw on 16/9/19.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import "ViewController.h"
#import "HWAutoScrollView.h"
//#import "Masonry.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *localLabel;
@property (strong, nonatomic) IBOutlet UILabel *remoteLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createControlByLocalImage];
    [self createControlByRemoteImage];
}

#pragma mark - 根据本地图片创建轮播视图
- (void)createControlByLocalImage
{
    NSArray *imageNameArray = @[@"0001_meitu", @"0002_meitu", @"0003_meitu"];
    HWAutoScrollView *view = [[HWAutoScrollView alloc] initWithImageNameArray:imageNameArray imageOnClickCallBack:^(int imageIndex){
        NSLog(@"-->> LocalImageIndex:%d", imageIndex);
    }];
    view.pageControlPosition = HWPageControlPositionCenter;
    view.imageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:view];
    
//    __weak typeof(self) weakSelf = self;
//    [view makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.localLabel.bottom).offset(5);
//        make.height.equalTo(@(150));
//    }];
}

#pragma mark - 根据远程图片创建轮播视图
- (void)createControlByRemoteImage
{
    NSArray *imageUrlArray = @[@"http://pic24.nipic.com/20121003/10754047_140022530392_2.jpg", @"http://img15.3lian.com/2015/a1/13/d/17.jpg", @"http://pic36.nipic.com/20131022/7786988_135813187182_2.jpg"];
    HWAutoScrollView *view = [[HWAutoScrollView alloc] initWithImageUrlArray:imageUrlArray placeHolder:@"loadingImage" imageOnClickCallBack:^(int imageIndex){
        NSLog(@"-->> RemoteImageIndex:%d", imageIndex);
    }];
    
    view.pageControlPosition = HWPageControlPositionLeft;
    view.imageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:view];
    
//    __weak typeof(self) weakSelf = self;
//    [view makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.remoteLabel.bottom).offset(5);
//        make.height.equalTo(@(150));
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
