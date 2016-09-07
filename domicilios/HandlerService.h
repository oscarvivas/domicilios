//
//  HandlerService.h
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SplashViewController.h"

@interface HandlerService : NSObject

extern NSString * const URL;

-(void) downData;

@property (nonatomic, strong) UIViewController *splash;

@end
