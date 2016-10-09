# AutoScrollView

AutoScrollView is used to load remote and local images, and automatically scroll.

![](2.gif)

### Requirements

* iOS 7.0 or later
	

### How To Use

* load remote image:

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

* load local image:

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

### Installation
 
Podfile

```
platform :ios, '7.0'
pod 'HWAutoScrollView'
```

Complete the installation by executing:

```
$ pod install
```

##### Import headers in your source files

In the source files where you need to use the library, import the header file:

```
#import "HWAutoScrollView.h"
```





