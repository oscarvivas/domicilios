//
//  Routing.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 5/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Routing : NSObject

-(void)goCategory:(UIViewController *) actual;
-(void)goItem:(UIViewController *) actual nameCategory:(NSString *)nameCategory;

@end
