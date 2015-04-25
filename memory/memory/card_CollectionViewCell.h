//
//  card_CollectionViewCell.h
//  memory
//
//  Created by Philipp Schmauk on 25.04.15.
//  Copyright (c) 2015 Stanislav Sokol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface card_CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cardBackImage;
@property (strong, nonatomic) IBOutlet UIImageView *cardImage;

@end


