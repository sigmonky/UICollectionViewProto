//
//  ChordIdentityViewController.h
//  CollectionDemo
//
//  Created by Weinstein, Randy - Nick.com on 9/2/14.
//  Copyright (c) 2014 Neil Smyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChordIdentityViewController;

@protocol ChordIdentityViewControllerDelegate <NSObject>
- (void)chordIdentityViewControllerDidCancel:(ChordIdentityViewController *)controller;
- (void)chordIdentityDidSave:(ChordIdentityViewController *)controller;
@end

@interface ChordIdentityViewController : UIViewController
@property (nonatomic, weak) id <ChordIdentityViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@end
