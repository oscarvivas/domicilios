//
//  HandlerImage.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 5/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "HandlerImage.h"

@implementation HandlerImage

NSString * const URLIMAGE = @"";

+ (void) loadCategoryImage :(int ) categoryId {
    
    NSString *typeImage = @"categories";
    [self downloadImage:categoryId typeImage:typeImage];
}

+ (void) loadSubcategoryImage:(int ) subcategoryId {
    
    NSString *typeImage = @"subcategories";
    [self downloadImage:subcategoryId typeImage:typeImage];
}

+ (void) loadItemsImage:(int ) itemId {
    
    NSString *typeImage = @"items";
    [self downloadImage:itemId typeImage:typeImage];
}

+ (BOOL) downloadImage :(int) imageId typeImage:(NSString *)typeImage {
    
    NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", typeImage, imageId];
    NSString *stringURL = [NSString stringWithFormat:@"%@img/%@/%d.jpg", URLIMAGE, typeImage, imageId];
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if ( urlData )
    {
        NSString *tmpDirectory = NSTemporaryDirectory();
        NSString *filePath = [tmpDirectory stringByAppendingPathComponent:fileName];
        [urlData writeToFile:filePath atomically:YES];
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
