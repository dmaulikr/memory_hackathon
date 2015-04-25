//
//  Memory_CollectionViewController.m
//  memory
//
//  Created by Stanislav Sokol on 25.04.15.
//  Copyright (c) 2015 Stanislav Sokol. All rights reserved.
//

#import "Memory_CollectionViewController.h"
#import "card_CollectionViewCell.h"

@interface Memory_CollectionViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *Memory_CollectionViewController;
@property (strong, nonatomic) NSArray *CardArray;


@end

@implementation Memory_CollectionViewController

static NSString * const reuseIdentifier = @"CardCell";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    memoryImages = [NSMutableArray arrayWithObjects:@"Prozessor2.jpg", @"apple2.jpg", @"dhbw2.jpg", @"flags2.jpg", @"pc2.jpg", @"strand2.jpg", @"wolf2.jpg", nil];
    
    [memoryImages addObjectsFromArray:memoryImages];
    
    for (NSUInteger i=0; i<memoryImages.count; i++) {
        NSUInteger remainingCount = memoryImages.count - i;
        NSUInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
        [memoryImages exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }

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
            firstCard = cell.cardImage.image;
            firstCardIndex = indexPath;
        } else if(flipCount==1){
            secondCard = cell.cardImage.image;
            secondCardIndex = indexPath;
            flipCount++;
        }else{
            if ([self compareCards ]) { // Karten gleich
                //Karten aus Spiel entfernen
                NSLog(@"gleiche Karte!\n");
            }else{
                NSLog(@"nicht gleiche Karte!\n");
                [self turnFaceDownWithCollection:collectionView]; // allways say where its defined @alfbeck
            }
            firstCard = cell.cardImage.image;
            firstCardIndex = indexPath;
            flipCount = 1;
        }
        
    }
}

-(bool)compareCards{
    return [firstCard isEqual:secondCard];
}
-(void) turnFaceDownWithCollection:(UICollectionView *) collectionView{
    card_CollectionViewCell *firstCell = (card_CollectionViewCell*) [collectionView cellForItemAtIndexPath:firstCardIndex];

    firstCell.cardImage.hidden = YES;
    firstCell.cardBackImage.hidden = NO;

    card_CollectionViewCell *sndCell = (card_CollectionViewCell*) [collectionView cellForItemAtIndexPath:secondCardIndex];
    
    sndCell.cardImage.hidden = YES;
    sndCell.cardBackImage.hidden = NO;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

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
