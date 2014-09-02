//
//  MyCollectionViewController.m
//  CollectionDemo
//
//  Created by Neil Smyth on 9/18/13.
//  Copyright (c) 2013 Neil Smyth. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ChordIdentityViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    MyFlowLayout *myLayout = [[MyFlowLayout alloc]init];

    [self.collectionView setCollectionViewLayout:myLayout animated:YES];

    UIGestureRecognizer *pinchRecognizer = 
         [[UIPinchGestureRecognizer alloc] 
            initWithTarget:self 
            action:@selector(handlePinch:)];

    [self.collectionView addGestureRecognizer:pinchRecognizer];

    _measures = [@[@"Cm7",@"F7",@"BbM7",@"?",@"F7",@"BbM7",@"Cm7",@"F7",@"BbM7"] mutableCopy];

}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender {

    // Get a reference to the flow layout

    MyFlowLayout *layout = 
          (MyFlowLayout *)self.collectionView.collectionViewLayout;

    // If this is the start of the gesture
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        // Get the initial location of the pinch?
        CGPoint initialPinchPoint = 
             [sender locationInView:self.collectionView];

        //Convert pinch location into a specific cell
        NSIndexPath *pinchedCellPath = 
             [self.collectionView indexPathForItemAtPoint:initialPinchPoint];

        // Store the indexPath to cell
        layout.currentCellPath = pinchedCellPath;
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        // Store the new center location of the selected cell
        layout.currentCellCenter = 
              [sender locationInView:self.collectionView];
        // Store the scale value
        layout.currentCellScale = sender.scale;
    }
    else
    {
        [self.collectionView performBatchUpdates:^{
            layout.currentCellPath = nil;
            layout.currentCellScale = 1.0;
        } completion:nil];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
     (UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView 
      numberOfItemsInSection:(NSInteger)section
{
    return _measures.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView
           dequeueReusableCellWithReuseIdentifier:@"MyCell"
           forIndexPath:indexPath];

    NSString *chordId;
    long row = [indexPath row];

    chordId = _measures[row];

    
    //myCell.chordId.contentMode = UIViewContentModeScaleAspectFit;
    myCell.chordId.text = chordId;
    return myCell;
}

#pragma mark -
#pragma mark UICollectionViewFlowLayoutDelegate
/*
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image;
    long row = [indexPath row];

    image = [UIImage imageNamed:_carImages[row]];

    NSLog(@"Image size: w = %f, h = %f", image.size.width, image.size.height);
    
    return image.size;
 
}
*/

#pragma mark -
#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    /*long row = [indexPath row];

    [_carImages removeObjectAtIndex:row];

    NSArray *deletions = @[indexPath];

    [self.collectionView deleteItemsAtIndexPaths:deletions];
    */
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MySupplementaryView *header = nil;

    if ([kind isEqual:UICollectionElementKindSectionHeader])
    {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind 
            withReuseIdentifier:@"MyHeader" 
            forIndexPath:indexPath];

        header.headerLabel.text = @"Car Image Gallery";
    }
    return header;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"identifyChord"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        ChordIdentityViewController *chordIdentityViewController = [navigationController viewControllers][0];
        chordIdentityViewController.delegate = self;
        NSLog(@"onto chord identification");
    }
}


- (void)chordIdentityViewControllerDidCancel:(ChordIdentityViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)chordIdentityDidSave:(ChordIdentityViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
