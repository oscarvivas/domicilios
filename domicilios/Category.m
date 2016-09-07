//
//  Category.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "Category.h"
#import <Realm/Realm.h>

@implementation Category

-(id) initWithInfo:(int)idCategory
      nameCategory:(NSString *)nameCategory
          img_path:(NSString *)img_path
{
    if ( self = [super init] ) {
        _idCategory = idCategory;
        _nameCategory = nameCategory;
        _img_path = img_path;
    }
    return self;
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"idCategory" : @0,
             @"nameCategory" : @"",
             @"img_path" : @""};
}

+ (NSString *)primaryKey {
    return @"nameCategory";
}

@end
