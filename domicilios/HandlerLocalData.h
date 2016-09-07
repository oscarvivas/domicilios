//
//  HandlerLocalData.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Category.h"
#import "Item.h"

@interface HandlerLocalData : NSObject

@property (nonatomic, strong) RLMNotificationToken *notification;

- (void) insertCategory:(Category *) category;
- (void) insertItems:(Item *) item;

- (RLMResults *) getCategories;
- (RLMResults *) getItems:(NSString *)categoryName
                    order:(int)order;
- (RLMResults *) getAllItems;

+(HandlerLocalData *) getSharedInstance;
-(void) delDatabase;
-(BOOL) existsData;

@end
