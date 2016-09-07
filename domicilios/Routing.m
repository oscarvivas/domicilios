//
//  Routing.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 5/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "Routing.h"
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ItemViewController.h"

@implementation Routing

-(void)goCategory:(UIViewController *) actual {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    ViewController *category = (ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    
    category.modalPresentationStyle = UIModalPresentationCustom;
    
    [actual presentViewController:category
                         animated:YES
                       completion:nil];

}

-(void)goItem:(UIViewController *) actual
 nameCategory:(NSString *)nameCategory
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    ItemViewController *item = (ItemViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ItemViewController"];
    item.nameCategory = nameCategory;
    item.modalPresentationStyle = UIModalPresentationCustom;
    
    [actual presentViewController:item
                         animated:YES
                       completion:nil];
    
}



@end
