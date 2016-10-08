Pod::Spec.new do |s|
s.name                  = "HWAutoScrollView"
s.version               = "0.0.1"
s.ios.deployment_target = '7.0'
s.summary               = "OC版广告轮播视图工具类"
s.homepage              = "https://github.com/hw20101101/HWAutoScrollViewDemo"
s.license               = "MIT"
s.authors               = { "hw20101101" => "huangwei1603@gmail.com" }
s.source                = { :git => "https://github.com/hw20101101/HWAutoScrollViewDemo.git", :tag => "s.version" }
s.frameworks            = 'UIKit'
s.source_files          = 'HWAutoScrollView/*.{h,m}'
s.requires_arc          = true

s.public_header_files = 'HWAutoScrollView/HeaderFiles.h'
#s.source_files = 'HWAutoScrollView/HeaderFiles.h'

s.dependency 'SDWebImage'
s.dependency 'Masonry'
end