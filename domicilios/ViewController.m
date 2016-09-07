//
//  ViewController.m
//  domicilios
//
//  Created by Oscar Ivan Vivas on 4/09/16.
//  Copyright © 2016 vivcom. All rights reserved.
//

#import "ViewController.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"
#import <Realm/Realm.h>
#import "HandlerLocalData.h"
#import "Routing.h"

static NSString *kCellId = @"cellId";

@interface ViewController  () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initilizing view
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //Load data
    tableDataArray = [[HandlerLocalData getSharedInstance] getCategories];
    
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

    [self addLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [(MPSkewedParallaxLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 250)];
}

- (NSString *)titleForIndex:(NSInteger)index {

    index = index - 1;
    Category *cat = [tableDataArray objectAtIndex:index];
    return cat.nameCategory;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return tableDataArray.count * 4; // random
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item % tableDataArray.count + 1;
    MPSkewedCell* cell = (MPSkewedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", index]];
    cell.text = [self titleForIndex:index];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%@ %zd %zd", NSStringFromSelector(_cmd), indexPath.item, index);
    NSInteger index = indexPath.item % tableDataArray.count;
    Category *cat = [tableDataArray objectAtIndex:index];
    Routing *rou = [[Routing alloc] init];
    [rou goItem:self nameCategory:cat.nameCategory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 30)];
    label.backgroundColor = [UIColor clearColor];
    //label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = @"Categorias";
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    [self.view addSubview:label];
}

@end
