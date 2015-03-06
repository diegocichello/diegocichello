//
//  ViewController.m
//  iOSChallenge
//
//  Created by Diego Cichello on 3/4/15.
//  Copyright (c) 2015 Cichello. All rights reserved.
//

#import "SelectItemsViewController.h"
#import "CircleButtonControl.h"
#import "ShowItemsViewController.h"

@interface SelectItemsViewController ()
@property (strong, nonatomic) IBOutlet CircleButtonControl *circleButtonOne;
@property (strong, nonatomic) IBOutlet CircleButtonControl *circleButtonTwo;
@property (strong, nonatomic) IBOutlet CircleButtonControl *circleButtonThree;
@property (strong, nonatomic) IBOutlet CircleButtonControl *circleButtonFour;
@property (strong, nonatomic) IBOutlet CircleButtonControl *circleButtonFive;
@property (strong, nonatomic) IBOutlet CircleButtonControl *circleButtonSix;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midRowRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midRowLeftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomRowLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomRowRightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topRowLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topRowRightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *buttonShuffle;
@property (weak, nonatomic) IBOutlet UIButton *buttonGo;

@property NSArray *allCircleButtons;

@end

@implementation SelectItemsViewController


#pragma mark View Methods

//---------------------------- View Methods ---------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];



    [self navigationBarSetup]; //Set the navigation bar to look as desired



        



    //set the string options of each one of the Circle Button Controls
    [self.circleButtonOne setOptionsArray:@[@"Small batch",@"Large batch",@"Mass market",@"One of a kind"]];
    [self.circleButtonTwo setOptionsArray:@[@"Sweet",@"Umami",@"Savory"]];
    [self.circleButtonThree setOptionsArray:@[@"Mushy",@"Smooth", @"Crunchy"]];
    [self.circleButtonFour setOptionsArray:@[@"Mild",@"Spicy"]];

    [self.circleButtonFive setOptionsArray:@[@"A Lot",@"A Little"]];
    [self.circleButtonSix setOptionsArray:@[@"Lunch",@"Snack",@"Dinner",@"Breakfast",@"Brunch"]];

    //create an Array with all button to fast iterate between it
    self.allCircleButtons = [[NSArray alloc]initWithObjects:self.circleButtonOne,self.circleButtonTwo,self.circleButtonThree,self.circleButtonFour,self.circleButtonFive,self.circleButtonSix, nil];

    //set the background color of every circlebuttoncontrol to clear, in storyboard I use white background to easily move then.
    for (CircleButtonControl *circle in self.allCircleButtons)
    {
        circle.backgroundColor = [UIColor clearColor];
    }





}

- (void) viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:true];


    dispatch_async(dispatch_get_main_queue(), ^{
        self.topRowLeftConstraint.constant -= self.view.frame.size.width;
        self.topRowRightConstraint.constant -= self.view.frame.size.width;

        self.midRowLeftConstraint.constant -= self.view.frame.size.width;
        self.midRowRightConstraint.constant -= self.view.frame.size.width;

        self.bottomRowLeftConstraint.constant -= self.view.frame.size.width;
        self.bottomRowRightConstraint.constant -= self.view.frame.size.width;

        self.buttonShuffle.alpha =0.0;
        self.buttonGo.alpha = 0.0;

        for (CircleButtonControl *circle in self.allCircleButtons)
        {
            circle.alpha = 1.0;
        }



        });



}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];


    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topRowLeftConstraint.constant += self.view.frame.size.width;
        self.topRowRightConstraint.constant += self.view.frame.size.width;
        [self.view layoutIfNeeded];

    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.midRowLeftConstraint.constant += self.view.frame.size.width;
        self.midRowRightConstraint.constant += self.view.frame.size.width;
        [self.view layoutIfNeeded];

    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bottomRowLeftConstraint.constant += self.view.frame.size.width;
        self.bottomRowRightConstraint.constant += self.view.frame.size.width;
        [self.view layoutIfNeeded];

    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.buttonGo.alpha = 1.0;
        self.buttonShuffle.alpha = 1.0;
        [self.view layoutIfNeeded];

    } completion:nil];
}






#pragma mark IBActions

//-----------------------IBActions -------------------------------------------------
- (IBAction)onShuffleButtonTapped:(id)sender
{

    //Shuffle all Circle Button Controls inside the array
    for (CircleButtonControl *circle in self.allCircleButtons)
    {
        [circle shuffleSelected];
    }


}

#pragma mark Segues

//--------------------------Segues------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Check if the Segue is the GoButtonSegue
    if ([segue.identifier isEqualToString:@"GoButtonSegue"])
    {
        NSMutableArray *array = [NSMutableArray new];  //new array to add objects
        ShowItemsViewController *showItemsVC = segue.destinationViewController;

        //Iterate between all Circle Button Controls to get the string that is selected
        for (CircleButtonControl *circle in self.allCircleButtons)
        {
            [array addObject:[circle getSelectedString]];

        }

        showItemsVC.optionsSelected = array;  //set the showItemsVC array to the currently array

    }
}


#pragma mark Navigation Controller Methods

//------------------------ Navigation Controller Methods----------------------------------


-(void)navigationBarSetup
{
    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_searchIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];

    UIBarButtonItem *calendarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_calendarIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(calendarAction)];

    UIBarButtonItem *compassButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_compassIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(compassAction)];

    UIBarButtonItem *hudMenuButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_menuIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(menuAction)];

    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:searchButtonItem, calendarButtonItem,compassButtonItem, nil];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.navigationItem.rightBarButtonItem = hudMenuButtonItem;
}

-(void)searchAction
{
    NSLog(@"Search button clicked");
}

-(void)calendarAction
{
    NSLog(@"Calendar button clicked");
}

-(void)compassAction
{
    NSLog(@"Compass button clicked");
}

-(void)menuAction
{
    NSLog(@"Menu button clicked");
}

@end
