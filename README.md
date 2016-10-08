# AutoScrollView


##### 效果图：

![](2.gif)


##### 用法:

* 根据远程图片创建轮播视图:

```
	NSArray *imageUrlArray = @[@"http://pic24.nipic.com/20121003/10754047_140022530392_2.jpg", @"http://img15.3lian.com/2015/a1/13/d/17.jpg", @"http://pic36.nipic.com/20131022/7786988_135813187182_2.jpg"];
    HWAutoScrollView *view = [[HWAutoScrollView alloc] initWithImageUrlArray:imageUrlArray placeHolder:@"loadingImage" imageOnClickCallBack:^(int imageIndex){
        NSLog(@"-->> RemoteImageIndex:%d", imageIndex);
    }];
    [self.view addSubview:view];
    
    __weak typeof(self) weakSelf = self;
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.remoteLabel.bottom).offset(5);
        make.height.equalTo(@(150));
    }];

```

* 根据本地图片创建轮播视图:

```
	NSArray *imageNameArray = @[@"0001_meitu", @"0002_meitu", @"0003_meitu"];
    HWAutoScrollView *view = [[HWAutoScrollView alloc] initWithImageNameArray:imageNameArray imageOnClickCallBack:^(int imageIndex){
        NSLog(@"-->> LocalImageIndex:%d", imageIndex);
    }];
    [self.view addSubview:view];
    
    __weak typeof(self) weakSelf = self;
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.localLabel.bottom).offset(5);
        make.height.equalTo(@(150));
    }];	

```

##### 安装：
* 下载此Demo之后，拖动HWAutoScrollView文件夹到项目中，导入HWAutoScrollView.h
* 此工具类依赖Masonry和SDWebImage，使用前请确保已安装Masonry和SDWebImage。

