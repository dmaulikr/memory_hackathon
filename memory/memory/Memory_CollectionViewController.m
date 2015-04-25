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
    
    memoryImages = [NSArray arrayWithObjects:@"Prozessor2.jpg", @"apple2.jpg", @"dhbw2.jpg", @"flags2.jpg", @"pc2.jpg", @"strand2.jpg", @"wolf2.jpg", nil];
    
    
    
    
//    // Uncomment the following line to preserve selection between presentations
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    
//    
//    // Do any additional setup after loading the view.
//    int maxNumCards = 12;
//    
//    NSMutableArray *firstSection = [[NSMutableArray alloc]init];
//    for (int i=0; i<maxNumCards; i++) {
//        [firstSection addObject:[NSString stringWithFormat:@"Cell: %d", i]];
//    }
//    self.CardArray = [[NSArray alloc] initWithObjects:firstSection, nil];
//    
//    [self.collectionView registerClass:[card_CollectionViewCell class] forCellWithReuseIdentifier:@"CardCell"];
//    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(200, 200)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    
//    [self.collectionView setCollectionViewLayout:flowLayout];
    
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
    return memoryImages.count * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *collectionImageView = (UIImageView*)[cell viewWithTag:100];
    
    
    int index;
    if (indexPath.item >= memoryImages.count) {
        index = indexPath.item - memoryImages.count;
    }else{
        index = indexPath.item;
    }
    
    NSLog(@"%d\n", index);
    
    collectionImageView.image = [UIImage imageNamed:[memoryImages objectAtIndex:index]];
    
    
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
        } else{
            secondCard = cell.cardImage.image;
            
            if ([self compareCards ]) { // Karten gleich
                //Karten aus Spiel entfernen
                NSLog(@"gleiche Karte!\n");
                flipCount = 0;
            }else{
                NSLog(@"nicht gleiche Karte!\n");
                [self turnFaceDown]; // allways say where its defined @alfbeck
            }
        }
        
    }
}

-(bool)compareCards{
    return [firstCard isEqual:secondCard];
}
-(void) turnFaceDown{
    //something
    flipCount = 0;
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
