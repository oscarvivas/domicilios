//
//  HandlerLocalData.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "HandlerLocalData.h"
#import <Realm/Realm.h>
#import "Category.h"
#import "Item.h"

@implementation HandlerLocalData

static HandlerLocalData *sharedInstance = nil;

+(HandlerLocalData *) getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

-(id) init {
    if ( self = [super init] ) {
        self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *note, RLMRealm *realm) {
            //Lo primero que se desee hacer en la base de datos
            
        }];
    }
    return self;
}

-(void) insertCategory:(Category *) category
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //[realm addObject:category];
    [Category createOrUpdateInDefaultRealmWithValue:category];
    [realm commitWriteTransaction];
}

- (void) insertItems:(Item *) item
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //[realm addObject:item];
    [Item createOrUpdateInDefaultRealmWithValue:item];
    [realm commitWriteTransaction];
}

- (RLMResults *) getCategories
{
    RLMResults *retval = [[Category allObjects] sortedResultsUsingProperty:@"nameCategory" ascending:YES];
    return retval;
}

- (RLMResults *) getItems:(NSString *)categoryName
              order:(int)order
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"nameCategory == %@", categoryName];
    RLMResults *items;
    
    switch (order) {
        case 0:
            items = [[Item objectsWithPredicate:pred] sortedResultsUsingProperty:@"rating" ascending:NO];
            break;
        case 1:
            items = [[Item objectsWithPredicate:pred] sortedResultsUsingProperty:@"delivery" ascending:YES];
            break;
        case 2:
            items = [[Item objectsWithPredicate:pred] sortedResultsUsingProperty:@"timeDelivery" ascending:YES];
            break;
        case 3:
            items = [[Item objectsWithPredicate:pred] sortedResultsUsingProperty:@"name" ascending:YES];
            break;
        default:
            items = [[Item objectsWithPredicate:pred] sortedResultsUsingProperty:@"name" ascending:YES];
            break;
    }
    return items;
}

- (RLMResults *) getAllItems
{
    RLMResults *items = [[Item allObjects] sortedResultsUsingProperty:@"name" ascending:YES];
    return items;
}

-(void) delDatabase
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

-(BOOL) existsData
{
    return NO;
}

@end
