//
//  ChordIdentityViewController.m
//  CollectionDemo
//
//  Created by Weinstein, Randy - Nick.com on 9/2/14.
//  Copyright (c) 2014 Neil Smyth. All rights reserved.
//

#import "ChordIdentityViewController.h"

@interface ChordIdentityViewController ()

@end

@implementation ChordIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)cancel:(id)sender
{
    [self.delegate chordIdentityViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    [self.delegate chordIdentityDidSave:self];
}
@end
