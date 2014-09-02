//
//  MyCollectionViewController.h
//  CollectionDemo
//
//  Created by Neil Smyth on 9/18/13.
//  Copyright (c) 2013 Neil Smyth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "MySupplementaryView.h"
#import "MyFlowLayout.h"
#import "ChordIdentityViewController.h"

@interface MyCollectionViewController : UICollectionViewController
<UICollectionViewDataSource,
UICollectionViewDelegate,
ChordIdentityViewControllerDelegate
>

@property (strong, nonatomic) NSMutableArray *measures;
@end
