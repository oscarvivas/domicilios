//
//  HandlerService.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "HandlerService.h"
#import "HandlerLocalData.h"
#import "HandlerImage.h"
#import "Category.h"
#import "Item.h"
#import "Presenter.h"
#import <UIKit/UIKit.h>
#import "Routing.h"

@implementation HandlerService
NSString * const URL = @"https://api.myjson.com/bins/1zib8";

- (void) downData {
    
    HandlerLocalData *localDataBase = [HandlerLocalData getSharedInstance];
    
    //clean data base
    [localDataBase delDatabase];
    
    if ([localDataBase existsData] == NO)
    {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", URL]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data,
                                                   NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSArray *categories = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:NULL];
                 if (categories.count == 0) {
                     [self finishLoadData];
                 }
                 
                 for (int i = 0; i<categories.count; i++) {
                     
                     NSDictionary *dictionary = [categories objectAtIndex:i];
                     
                     Category *cat = [self getCategorieFromJson:dictionary];
                     cat.idCategory = i;
                     [localDataBase insertCategory:cat];
                     //[HandlerImage loadCategoryImage:[[categoryDictionary objectForKey:@"categorias"] intValue]];

                     Item *item = [self getItemsFromJson:dictionary];
                     item.idItem = i;
                     //[HandlerImage loadItemsImage:[[itemDictionary objectForKey:@"id"] intValue]];

                     //[cat.items addObject:item];
                     [localDataBase insertItems:item];

                     
                     if (i == (categories.count-1)) {
                         [self finishLoadData];
                     }
                     
                 }
                 
             }
             else if(connectionError != nil)
             {
                 NSString *errorMessage = [NSString stringWithFormat:@"No se puede conectar con el servidor %@", connectionError];
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
                 [av show];
                 NSLog(@"%@", connectionError);
             }
         }];
        
    }
    else
    {
        [self finishLoadData];
    }
    
}

-(Category *) getCategorieFromJson :(NSDictionary *)categoryDictionary
    
{
    
    Category *catego = [[Category alloc] init];
    
    catego.idCategory = [[categoryDictionary objectForKey:@"categorias"] intValue];
    catego.nameCategory = [categoryDictionary objectForKey:@"categorias"];
    catego.img_path = [categoryDictionary objectForKey:@"logo_path"];
    
    return catego;
}

-(Item *) getItemsFromJson :(NSDictionary *)itemDic {
    
    Item *item = [[Item alloc] init];
    
    item.idItem = [[itemDic objectForKey:@"nombre"] intValue];
    item.name = [itemDic objectForKey:@"nombre"];
    item.nameCategory = [itemDic objectForKey:@"categorias"];
    item.delivery = [[itemDic objectForKey:@"domicilio"] floatValue];
    item.img_path = [itemDic objectForKey:@"logo_path"];
    item.rating = [[itemDic objectForKey:@"rating"] intValue];
    item.timeDelivery = [[itemDic objectForKey:@"tiempo_domicilio"] intValue];
    
    NSString *locateString = [itemDic objectForKey:@"ubicacion_txt"];
    NSArray  *locateArray = [locateString componentsSeparatedByString: @","];
    if(locateArray.count>0)
    {
        item.latitude = [locateArray objectAtIndex: 0];
    }
    if(locateArray.count>1)
    {
        item.longitude = [locateArray objectAtIndex:1];
    }
    
    return item;
}

-(NSDate *) getDate :(NSString *) dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

-(void)finishLoadData {
    
    Routing *routing = [[Routing alloc] init];
    [routing goCategory:_splash];
}

@end

