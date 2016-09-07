//
//  Category.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Item.h"

@interface Category : RLMObject

@property int idCategory;
@property NSString *nameCategory;
@property NSString *img_path;

-(id) initWithInfo:(int)idCategory
      nameCategory:(NSString *)nameCategory
          img_path:(NSString *)img_path;

@property RLMArray<Item> *items;

@end

RLM_ARRAY_TYPE(Category)
