//
//  XRCollectionViewCell.m
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import "XRCollectionViewCell.h"
@interface XRCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation XRCollectionViewCell
- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
}
@end
