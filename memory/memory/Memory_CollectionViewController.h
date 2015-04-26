//
//  Memory_CollectionViewController.h
//  memory
//
//  Created by Stanislav Sokol on 25.04.15.
//  Copyright (c) 2015 Stanislav Sokol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Memory_CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

-(void)turnFaceDownWithCollection:(UICollectionView *)collection;    // between interface declaration and end @alfbeck
-(bool)compareCards;

@end

NSMutableArray *memoryImages;

UIImage *firstCard;
UIImage *secondCard;

UIImageView *firstImageView;
UIImageView *secondImageView;


NSIndexPath *firstCardIndex;
NSIndexPath *secondCardIndex;

int flipCount = 0;
int tryCount = 0;
int matchedPairCount = 0;
