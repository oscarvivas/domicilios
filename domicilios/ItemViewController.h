//
//  ItemViewController.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 5/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "AwesomeMenu.h"
#import <CoreLocation/CoreLocation.h>

@interface ItemViewController : UIViewController <AwesomeMenuDelegate, CLLocationManagerDelegate>
{
    RLMResults *tableDataArray;
    CLLocation *currentLocation;
}

@property (strong, nonatomic) NSString *nameCategory;
@property (nonatomic) int selectOrder;

@end
