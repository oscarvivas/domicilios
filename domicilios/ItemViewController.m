//
//  ItemViewController.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 5/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "ItemViewController.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"
#import <Realm/Realm.h>
#import "HandlerLocalData.h"
#import <CoreLocation/CoreLocation.h>

static NSString *kCellId = @"cellId";

@interface ItemViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
{
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //initialice location
    locationManager = [[CLLocationManager alloc] init];
    [self getCurrentLocation:nil];
    
    //Background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //Load data
    _selectOrder = 0;
    tableDataArray = [[HandlerLocalData getSharedInstance] getItems:_nameCategory order:_selectOrder];
    
    //Initialice table
    MPSkewedParallaxLayout *layout = [[MPSkewedParallaxLayout alloc] init];
    layout.lineSpacing = 2;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 250);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:image];
    [self.collectionView registerClass:[MPSkewedCell class] forCellWithReuseIdentifier:kCellId];
    [self.view addSubview:self.collectionView];

    //Add orden button
    [self addOrderMenu];
   
    //add button back
    [self addBackButton];
    
    //add Title
    [self addLabel];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [(MPSkewedParallaxLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 250)];
}

- (NSString *)titleForIndex:(NSInteger)index {
    
    index = index - 1;
    Item *item = [tableDataArray objectAtIndex:index];
    NSString *text = @"";
    long lat = [item.latitude longLongValue];
    long longi = [item.longitude longLongValue];
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat longitude:longi];
    CLLocationDistance distance = [currentLocation distanceFromLocation:locA];
    
    switch (_selectOrder) {
        case 0:
            text = [NSString stringWithFormat:@"%@ - recomendaciones %zd", item.name, item.rating];
            break;
        case 1:
            text = [NSString stringWithFormat:@"%@ - precio $%.2f", item.name, item.delivery];
            break;
        case 2:
            text = [NSString stringWithFormat:@"%@ - tiempo de entrega %zd", item.name, item.timeDelivery];
            break;
        case 3:
            text = [NSString stringWithFormat:@"%@ - distancia %zd", item.name, distance];
            break;
        default:
            text = [NSString stringWithFormat:@"%@ - recomendaciones %zd", item.name, item.rating];
            break;
    }
    return text;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int num = (int)tableDataArray.count;
    if(tableDataArray.count > 1)
    {
        num = (int)(tableDataArray.count * 2);
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item % tableDataArray.count + 1;
    MPSkewedCell* cell = (MPSkewedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    Item *item = [tableDataArray objectAtIndex:(index-1)];
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", item.name]];
    cell.text = [self titleForIndex:index];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSInteger index = indexPath.item % tableDataArray.count;
    //NSLog(@"%@ %zd %zd", NSStringFromSelector(_cmd), indexPath.item, index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addOrderMenu {
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];

    UIImage *starImage = [UIImage imageNamed:@"comment-button.png"]; //recomendado
    UIImage *moneyImage = [UIImage imageNamed:@"money-button.png"];  //precios
    UIImage *smileImage = [UIImage imageNamed:@"smile-button.png"];  //tiempo de entrega
    UIImage *locationImage = [UIImage imageNamed:@"location-button.png"]; //ubicacion
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:moneyImage
                                                    highlightedContentImage:nil];
    
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:smileImage
                                                    highlightedContentImage:nil];
    
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:locationImage
                                                    highlightedContentImage:nil];
    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    
    // the start item, similar to "add" button of Path
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem menuItems:menuItems];
    menu.delegate = self;
    
    menu.startPoint = CGPointMake(self.view.frame.size.width - 40, self.view.frame.size.height - 40);
    menu.menuWholeAngle = - M_PI / 2;
    
    [self.view addSubview:menu];
    
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    //NSLog(@"Select the index : %zd",idx);
    switch (idx) {
        case 0:
            _selectOrder = 0;
            break;
        case 1:
            _selectOrder = 1;
            break;
        case 2:
            _selectOrder = 2;
            break;
        case 3:
            _selectOrder = 3;
            break;
        default:
            _selectOrder = 0;
            break;
    }
    //tableDataArray = [[HandlerLocalData getSharedInstance] getAllItems];
    tableDataArray = [[HandlerLocalData getSharedInstance] getItems:_nameCategory order:_selectOrder];
    [self.collectionView reloadData];
}

- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    //NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    //NSLog(@"Menu is open!");
}

-(void)addBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(backClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 20, 30, 30);
    UIImage *buttonImageNormal = [UIImage imageNamed:@"boton_back"];
    [button setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    [self.view addSubview:button];
}

-(void) backClicked:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 300, 30)];
    label.backgroundColor = [UIColor clearColor];
    //label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = @"Restaurantes";
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    [self.view addSubview:label];
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //Default locate
    currentLocation = [[CLLocation alloc] initWithLatitude:4.6734801 longitude:-74.0570642];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    currentLocation = newLocation;
    /*
    if (currentLocation != nil) {
        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }*/
}

@end
