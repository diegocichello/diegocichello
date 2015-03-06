//
//  CircleButtonControl.h
//  iOSChallenge
//
//  Created by Diego Cichello on 3/4/15.
//  Copyright (c) 2015 Cichello. All rights reserved.
//

#import <UIKit/UIKit.h>


#define TB_FONTSIZEIPHONE4S 13              //The size of the textfield font on iphone 4s
#define TB_FONTSIZEIPHONE5S 18                //The size of the textfield font on iphone 5s
#define TB_FONTSIZEIPHONE6 22                //The size of the textfield font on iphone 6
#define TB_FONTSIZEIPHONE6P 24             //The size of the textfield font on iphone 6plus
#define TB_FONTFAMILY @"Kohinoor Devanagari"  //The font family of the textfield font

@interface CircleButtonControl : UIControl



@property NSArray *optionsArray;

- (void) shuffleSelected;
- (NSString *) getSelectedString;



@end
