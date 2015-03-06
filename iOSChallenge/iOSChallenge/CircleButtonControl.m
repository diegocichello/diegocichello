//
//  CircleButtonControl.m
//  iOSChallenge
//
//  Created by Diego Cichello on 3/4/15.
//  Copyright (c) 2015 Cichello. All rights reserved.
//

#import "CircleButtonControl.h"

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )



/** Parameters **/


@interface CircleButtonControl ()

@property int sectionSelected;
@property UITextField *textField;
@property NSTimer *timer;
@property int ticksRemaining;

@end

@implementation CircleButtonControl



#pragma mark - Drawing Functions -

//Use the draw rect to draw the Background, the Circle and the Sections
-(void)drawRect:(CGRect)rect{

    [super drawRect:rect];

    

    UIFont *font = [self setFontBasedOnScreenSize]; //set the font based on the screen size


    //Draw a text field inside the circle setting its properties
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10,self.frame.size.height/2-25,self.frame.size.width-20,50)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.textColor = [UIColor whiteColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.font = font;

    _textField.enabled = NO;

    //Before adding the new textField inside the subview check if there is already one, probably
    // a previous one, so just remove then from the superview

    for (UITextField *txt in self.subviews)
    {
        [txt removeFromSuperview];
    }
     

    //If the text field is not yet inside the subviews just add it as new one

    [self addSubview:_textField];


    CGContextRef ctx = UIGraphicsGetCurrentContext();  //grab current graphics context of Core Graphics



    //Draw the Circle Background

    CGRect bounds = [self bounds];

    CGPoint center; //grab the center of the Circle Button Control
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGContextSaveGState(ctx);

    CGContextSetLineWidth(ctx,2);





    int startAngle = 90; //the first angle to be considered is 90 degrees
    int anglePerSection = 360 / self.optionsArray.count; // considering a full circle have 360 degrees, split it into identical sections

    _textField.text = [[self.optionsArray objectAtIndex:self.sectionSelected] uppercaseString]; //set all strings to upper case to look like .psd file provided

    //Creating the sections

    for (int i=0; i<self.optionsArray.count;i++)
    {
        //Check if the section is currently selected if it is paint it as red instead of pink
        if (self.sectionSelected == i)
        {
            CGContextSetRGBStrokeColor(ctx,195.0/255.0,83.0/255.0,84.0/255.0,1.0);
        }
        else
        {
            CGContextSetRGBStrokeColor(ctx,107.0/255.0,27.0/255.0,55.0/255.0,1.0);
        }

        //draw the section with the correct color
        CGContextAddArc(ctx,center.x,center.y,(self.frame.size.width/2)-5,ToRad(startAngle-5),ToRad(startAngle-anglePerSection+5),YES);
        CGContextStrokePath(ctx);
        startAngle = startAngle - anglePerSection; //change the start angle of the next section
    }


    //Create the background circle
    CGRect circleRect = CGRectMake( 0, 0, self.frame.size.width , self.frame.size.height );
    circleRect = CGRectInset(circleRect, 8, 8);

    // Fill
    CGContextSetRGBFillColor(ctx,0.0,0.0,0.0,0.2);
    CGContextFillEllipseInRect(ctx, circleRect);









}



- (void) shuffleSelected
{

    //Simple timer to make the animation of the Strings being shuffled
    self.timer = [[NSTimer alloc]init];
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                                  target: self selector: @selector(handleTimerTick) userInfo: nil repeats: YES];
    self.ticksRemaining =0;


    

}

-(void)handleTimerTick
{
    //Increment the ticks remaining
    self.ticksRemaining++;

    if (self.ticksRemaining<=10)
    {
        //Get a random section based in the number of options
        self.sectionSelected = arc4random_uniform(self.optionsArray.count);

        [self setNeedsDisplay];

        
    }
    else
    {
        [self.timer invalidate];
    }
    
}

//get current state of selected string
- (NSString *) getSelectedString
{
    return (NSString *)self.optionsArray[self.sectionSelected];
}


- (UIFont *) setFontBasedOnScreenSize
{
    //Grab Screen Size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGFloat size;

    //Set the font size based on the size of the device
    if (screenWidth==320 && screenHeight==568) //iphone5s
    {
        size = TB_FONTSIZEIPHONE5S;
    }
    else if (screenWidth==375 && screenHeight==667)
    {
        size = TB_FONTSIZEIPHONE6; //iphone 6
    }
    else if (screenWidth==414 && screenHeight==736)
    {
        size = TB_FONTSIZEIPHONE6P;
    }
    else
    {
        size = TB_FONTSIZEIPHONE4S;
    }
    return [UIFont fontWithName:TB_FONTFAMILY size:size];
}

//Handle the click to increment the section in one
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.optionsArray.count-1 == self.sectionSelected)
    {
        self.sectionSelected =0;
    }
    else
    {
        self.sectionSelected++;
    }
    [self setNeedsDisplay];


}



@end
