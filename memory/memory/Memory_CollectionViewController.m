//
//  Memory_CollectionViewController.m
//  memory
//
//  Created by Stanislav Sokol on 25.04.15.
//  Copyright (c) 2015 Stanislav Sokol. All rights reserved.
//

#import "Memory_CollectionViewController.h"
#import "card_CollectionViewCell.h"
@import UIKit;

@interface Memory_CollectionViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *ProgressLabel;
@property (strong, nonatomic) IBOutlet UILabel *TryLabel;



@end

@implementation Memory_CollectionViewController

static NSString * const reuseIdentifier = @"CardCell";


- (IBAction)startANewGame:(id)sender { // IN DRAFT
    NSLog(@"neu");
    tryCount = 0;
    matchedPairCount = 0;
    flipCount = 0;
    for (card_CollectionViewCell *cell in self.collectionView.visibleCells){
        cell.cardBackImage.hidden = NO;
        cell.cardImage.hidden = YES;
    }
    
//   for (NSUInteger i=0; i<self.collectionView.memoryImages.count; i++) {
 //       NSUInteger remainingCount = memoryImages.count - i;
   //    NSUInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
   //     [memoryImages exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
  // }
    
    [self updateLabels];
}

-(void)updateLabels{
    [self.ProgressLabel setText: [NSString stringWithFormat:  @"%d von %u Paaren gefunden!", matchedPairCount, memoryImages.count/2 ]];
    [self.TryLabel setText: [NSString stringWithFormat:  @"%d Züge genutzt!", tryCount]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    memoryImages = [NSMutableArray arrayWithObjects:@"01.png",@"02.png",@"03.png",@"04.png",@"05.png",@"06.png",@"07.jpg",@"08.png",@"09.png",@"10.png",nil];
    
    [memoryImages addObjectsFromArray:memoryImages];
    
   for (NSUInteger i=0; i<memoryImages.count; i++) {
        NSUInteger remainingCount = memoryImages.count - i;
        NSUInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
       [memoryImages exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    [self updateLabels];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return memoryImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *collectionImageView = (UIImageView*)[cell viewWithTag:100];

    
    collectionImageView.image = [UIImage imageNamed:[memoryImages objectAtIndex:indexPath.item]];
    
    
    return cell;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    card_CollectionViewCell *cell = (card_CollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.cardImage.hidden) {
        cell.cardImage.hidden = NO;
        cell.cardBackImage.hidden =YES;
        

        
        if (flipCount == 0) { //erste Karte von einem Paar
            flipCount++;
            firstImageView = cell.cardImage;
            //firstCard = cell.cardImage.image;
            firstCardIndex = indexPath;
        } else if(flipCount==1){
            secondImageView = cell.cardImage;
            //secondCard = cell.cardImage.image;
            secondCardIndex = indexPath;
            flipCount++;
            tryCount++;
            
            if (matchedPairCount == memoryImages.count / 2 - 1) {
                matchedPairCount++;
                NSLog(@"gewonnen");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Gewonnen!"
                                                               message: [NSString stringWithFormat: @"in %d Zügen", tryCount ]
                                                              delegate: self
                                                     cancelButtonTitle: nil
                                                     otherButtonTitles:@"OK",nil];
                
                [alert setTag:1];
                [alert show];
                [firstImageView.layer setBorderColor:[[UIColor greenColor]CGColor]];
                [firstImageView.layer setBorderWidth:2.0];
                [secondImageView.layer setBorderColor:[[UIColor greenColor]CGColor]];
                [secondImageView.layer setBorderWidth:2.0];
            }
            
        }else{
            if ([self compareCards ]) { // Karten gleich
                //Karten aus Spiel entfernen
                matchedPairCount++;
                [firstImageView.layer setBorderColor:[[UIColor greenColor]CGColor]];
                [firstImageView.layer setBorderWidth:2.0];
                [secondImageView.layer setBorderColor:[[UIColor greenColor]CGColor]];
                [secondImageView.layer setBorderWidth:2.0];
            }else{
                [self turnFaceDownWithCollection:collectionView]; // allways say where its defined @alfbeck
            }
            firstImageView = cell.cardImage;
            //firstCard = cell.cardImage.image;
            firstCardIndex = indexPath;
            flipCount = 1;
        }
        
    }

    [self updateLabels];
}

-(bool)compareCards{
    return [firstImageView.image isEqual:secondImageView.image];
}
-(void) turnFaceDownWithCollection:(UICollectionView *) collectionView{
    card_CollectionViewCell *firstCell = (card_CollectionViewCell*) [collectionView cellForItemAtIndexPath:firstCardIndex];
    card_CollectionViewCell *sndCell = (card_CollectionViewCell*) [collectionView cellForItemAtIndexPath:secondCardIndex];
    
    firstCell.cardBackImage.hidden = NO;
    sndCell.cardBackImage.hidden = NO;
    
    firstCell.cardImage.hidden = YES;
    sndCell.cardImage.hidden = YES;
}

-(BOOL)shouldAutorotate{
    return NO;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
