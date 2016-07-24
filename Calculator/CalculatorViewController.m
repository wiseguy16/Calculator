//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Gregory Weiss on 7/21/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

{
    // Instance variables:
    // Not using this time.
    // Making all "variables" as properties
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (strong, nonatomic) NSMutableString *firstNumberAsAString;
@property (strong, nonatomic) NSMutableString *secondNumberAsAString;
@property (strong, nonatomic) NSMutableString *operatorAsAString;
@property (strong, nonatomic) NSMutableString *storedOperatorAsAString;
@property (strong, nonatomic) NSMutableString *currentTextForLabel;
@property (strong, nonatomic) NSMutableString *resultAsAString;
@property (strong, nonatomic) NSMutableString *clearTextAsAString;
@property double firstNumberAsADouble;
@property double secondNumberAsADouble;
@property double resultAsADouble;
@property BOOL panicStateSoReset;
@property int countOfOperatorsPressed;
@property BOOL plusMinusTurnedOn;


@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNumberAsAString = [[NSMutableString alloc] init];
    self.secondNumberAsAString = [[NSMutableString alloc] init];
    self.operatorAsAString = [[NSMutableString alloc] init];
    self.storedOperatorAsAString = [[NSMutableString alloc] init];
    self.currentTextForLabel = [[NSMutableString alloc] init];
    self.resultAsAString = [[NSMutableString alloc] init];
    self.panicStateSoReset = NO;
    self.countOfOperatorsPressed = 0;
    self.plusMinusTurnedOn = NO;

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Handlers



#pragma mark - Numbers were tapped here

- (IBAction)numberTapped:(UIButton *)sender
{
    if ([self.operatorAsAString isEqual:@""])
    {
        [self.firstNumberAsAString appendString:sender.currentTitle];
        self.firstNumberAsADouble = self.firstNumberAsAString.doubleValue;
        self.currentTextForLabel = self.firstNumberAsAString;
//        if (self.plusMinusTurnedOn == YES)
//        {
//            self.firstNumberAsADouble = self.firstNumberAsADouble * -1;
//            
//            self.plusMinusTurnedOn = NO;
//        }
//        self.currentTextForLabel = [NSMutableString stringWithFormat:@"%g", self.firstNumberAsADouble];
        
        
        
        NSLog(@"First number is %@", self.currentTextForLabel);
        NSLog(@"First actual number is %f", self.firstNumberAsADouble);
        NSLog(@"Panic stat is %d", self.panicStateSoReset);
        }
    else
    {
        [self.secondNumberAsAString appendString:sender.currentTitle];
        self.currentTextForLabel = self.secondNumberAsAString;
        self.secondNumberAsADouble = self.secondNumberAsAString.doubleValue;
        NSLog(@"Second number is %@", self.currentTextForLabel);
        NSLog(@"Second actual number is %f", self.secondNumberAsADouble);
    }
    
    [self updateTheLabel];
    
}

#pragma mark - Plus/Minus & Percent Action handlers

- (IBAction)plusMinusTapped:(UIButton *)sender
{

    
    if ([self.operatorAsAString isEqual:@""])
    {
        self.firstNumberAsADouble = self.firstNumberAsADouble * -1;
        self.currentTextForLabel = [NSMutableString stringWithFormat:@"%g", self.firstNumberAsADouble];
        NSLog(@"First actual number is %f", self.firstNumberAsADouble);
    }
    else
    {
        self.secondNumberAsADouble = self.secondNumberAsADouble * -1;
        self.currentTextForLabel = [NSMutableString stringWithFormat:@"%g", self.secondNumberAsADouble];
        NSLog(@"Second actual number is %f", self.secondNumberAsADouble);

    }
    
     [self updateTheLabel];
    
}


- (IBAction)percentTapped:(UIButton *)sender
{
    if ([self.operatorAsAString isEqual:@""])
    {
        self.firstNumberAsADouble = self.firstNumberAsADouble / 100;
        self.currentTextForLabel = [NSMutableString stringWithFormat:@"%g", self.firstNumberAsADouble];
        NSLog(@"First actual number is %f", self.firstNumberAsADouble);
    }
    else
    {
        self.secondNumberAsADouble = self.secondNumberAsADouble  / 100;
        self.currentTextForLabel = [NSMutableString stringWithFormat:@"%g", self.secondNumberAsADouble];
        NSLog(@"Second actual number is %f", self.secondNumberAsADouble);
        
    }
    
    [self updateTheLabel];
   
}


#pragma mark - Operators were tapped here

- (IBAction)operatorTapped:(UIButton *)sender
{
    // IF statement addresses if another operator is pressed after 1st calculation
    // Essentially resets like a clear button
    
    if (self.countOfOperatorsPressed == 0)
    {
    [self.operatorAsAString appendString:sender.currentTitle];
    self.storedOperatorAsAString = self.operatorAsAString;
    self.currentTextForLabel = self.operatorAsAString;
    NSLog(@"%@", self.operatorAsAString);
    [self updateTheLabel];
   // self.panicStateSoReset = YES;
   // NSLog(@"Panic stat is %d", self.panicStateSoReset);
    self.countOfOperatorsPressed = self.countOfOperatorsPressed + 1;
    }
    else
    {
        self.firstNumberAsADouble = 0;
        self.secondNumberAsADouble = 0;
        self.resultAsADouble = 0;
        [self.firstNumberAsAString setString:@""];
        [self.secondNumberAsAString setString:@""];
        [self.operatorAsAString setString:@""];
        [self.operatorAsAString isEqual:@""];
        [self.currentTextForLabel setString:@""];
        self.countOfOperatorsPressed = 0;
        [self updateTheLabel];
    }
}

#pragma mark -Equals button was tapped here


- (IBAction)equalsTapped:(UIButton *)sender
{
    
    // PUT A BUNCH OF IF STATEMENTS HERE!!!!!

    if ([self.operatorAsAString  isEqual: @"+"])
{
    self.resultAsADouble =  self.firstNumberAsADouble + self.secondNumberAsADouble;
    }
    else if ([self.operatorAsAString  isEqual: @"-"])
    {
      self.resultAsADouble =  self.firstNumberAsADouble - self.secondNumberAsADouble;
    }
    else if ([self.operatorAsAString  isEqual: @"*"])
    {
      self.resultAsADouble =  self.firstNumberAsADouble * self.secondNumberAsADouble;
    }
    else if ([self.operatorAsAString  isEqual: @"÷"])  //(self.secondNumberAsADouble != 0)
    {
        if (self.secondNumberAsADouble != 0)
        {
       self.resultAsADouble =  self.firstNumberAsADouble / self.secondNumberAsADouble;
        }
        else
        {
            // This means they are trying to divide by 0, so turn on the panic!
            self.panicStateSoReset = YES;
        }
    }
    else
    {
        self.resultAsADouble =  0;
    }
        
  if (self.panicStateSoReset != YES)
  {
    // %g FIXES TRAILING 0's
    self.currentTextForLabel = [NSMutableString stringWithFormat:@"%g", self.resultAsADouble];            //[NSString stringWithFormat:@"%f", self.resultAsADouble];
    [self updateTheLabel];
  }
    else
    {
        // FIXED FOR DIVIDE BY 0
        self.displayLabel.text = @"Error";
    }
    
}

#pragma mark -Clear button was tapped here

- (IBAction)clearTapped:(UIButton *)sender
{
    self.panicStateSoReset = NO;
    self.firstNumberAsADouble = 0;
    self.secondNumberAsADouble = 0;
    self.resultAsADouble = 0;
    [self.firstNumberAsAString setString:@""];
    [self.secondNumberAsAString setString:@""];
    [self.operatorAsAString setString:@""];
    [self.operatorAsAString isEqual:@""];
    [self.currentTextForLabel setString:@""];
    self.countOfOperatorsPressed = 0;
     [self updateTheLabel];
}



#pragma mark - Misc methods - method for updating the label

-(void) updateTheLabel
{
    self.displayLabel.text = [NSString stringWithFormat:@"%@", self.currentTextForLabel];
}







@end
