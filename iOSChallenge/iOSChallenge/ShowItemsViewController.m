//
//  ShowItemsViewController.m
//  iOSChallenge
//
//  Created by Diego Cichello on 3/5/15.
//  Copyright (c) 2015 Cichello. All rights reserved.
//

#import "ShowItemsViewController.h"

@interface ShowItemsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *item1Label;
@property (weak, nonatomic) IBOutlet UILabel *item2Label;
@property (weak, nonatomic) IBOutlet UILabel *item3Label;
@property (weak, nonatomic) IBOutlet UILabel *item4Label;
@property (weak, nonatomic) IBOutlet UILabel *item5Label;
@property (weak, nonatomic) IBOutlet UILabel *item6Label;


@end

@implementation ShowItemsViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.item1Label.text = self.optionsSelected[0];
    self.item2Label.text = self.optionsSelected[1];
    self.item3Label.text = self.optionsSelected[2];
    self.item4Label.text = self.optionsSelected[3];
    self.item5Label.text = self.optionsSelected[4];
    self.item6Label.text = self.optionsSelected[5];

}

@end
