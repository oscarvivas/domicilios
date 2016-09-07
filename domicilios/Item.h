//
//  Item.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Item : RLMObject

@property int idItem;
@property NSString *name;
@property NSString *nameCategory;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *img_path;
@property float delivery;
@property int timeDelivery;
@property int rating;

-(id) initWithInfo:(int )idItem
      nameCategory:(NSString *)nameCategory
              name:(NSString *)name
          img_path:(NSString *)img_path
          delivery:(float )delivery
      timeDelivery:(int )timeDelivery
          latitude:(NSString *)latitude
         longitude:(NSString *)longitude
            rating:(int )rating;

@end

RLM_ARRAY_TYPE(Item)
