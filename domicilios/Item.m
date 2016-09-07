//
//  Item.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "Item.h"
#import <Realm/Realm.h>

@implementation Item

-(id) initWithInfo:(int )idItem
      nameCategory:(NSString *)nameCategory
              name:(NSString *)name
          img_path:(NSString *)img_path
          delivery:(float )delivery
      timeDelivery:(int )timeDelivery
          latitude:(NSString *)latitude
         longitude:(NSString *)longitude
            rating:(int )rating
{
    if ( self = [super init] ) {
        _idItem = idItem;
        _nameCategory = nameCategory;
        _name = name;
        _img_path = img_path;
        _delivery = delivery;
        _timeDelivery = timeDelivery;
        _latitude = latitude;
        _longitude = longitude;
        _rating = rating;
    }
    return self;
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"idItem" : @0,
             @"name" : @"",
             @"nameCategory" : @"",
             @"img_path" : @"",
             @"latitude" : @"",
             @"longitude" : @"",
             @"delivery" : @0,
             @"timeDelivery" : @0,
             @"rating" : @0
             };
}

+ (NSString *)primaryKey {
    return @"idItem";
}


@end


