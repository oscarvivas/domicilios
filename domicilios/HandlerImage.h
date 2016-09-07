//
//  HandlerImage.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 5/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandlerImage : NSObject

+ (void) loadCategoryImage:(int ) categoryId;

+ (void) loadSubcategoryImage:(int ) subcategoryId;

+ (void) loadItemsImage:(int ) itemId;

@end
