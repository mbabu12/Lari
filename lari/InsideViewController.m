//
//  InsideViewController.m
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import "InsideViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WebViewController.h"
#import "AppDelegate.h"

@interface InsideViewController ()

@end

@implementation InsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    toGel = YES;
    self.scrollView.scrollEnabled = NO;
    self.changeCur.layer.cornerRadius = 10;
    self.changeCur.clipsToBounds = YES;
    self.title = @"კონვერტაცია";
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    
    [self setData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapper];
    
    [self.textField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];

}

- (void)textFieldDidChange:(id)sender {
    [self changeValue];
}

/*
-(void)viewDidAppear:(BOOL)animated
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIDeviceOrientationPortrait] forKey:@"orientation"];

    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    appDelegate -> rotate = NO;

  //  UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
  //  if (deviceOrientation == UIDeviceOrientationPortrait)
  //  {
          // }
  //  [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: deviceOrientation] forKey:@"orientation"];
}
*/
- (void)handleSingleTap:(id)sender{
    [self.view endEditing:YES];
}

- (void)setData{
    [self.flagImage setImage:[UIImage imageNamed:self.myValue.imageName]];
    [self.fromImage setImage:[UIImage imageNamed:self.myValue.imageName]];
    [self.currencyLabel setText:self.myValue.name];
    [self.valueLabel setText:self.myValue.value];
    [self.numberLabel setText:self.myValue.number];
    self.numberLabel.textColor = self.myValue.color;
    float temp = [self.myValue.value floatValue];
    [self.resultLabel setText:[NSString stringWithFormat:@"%@ %@", [NSString stringWithFormat:@"%.02f",temp], @"GEL"]];
    [self.textField setText:@"1"];
}

-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + 200)];
}

- (IBAction)didChange:(id)sender {
    if(toGel){
        toGel = NO;
        [self.changeCur setTitle:@"<" forState:UIControlStateNormal];
    }
    else{
        toGel = YES;
        [self.changeCur setTitle:@">" forState:UIControlStateNormal];

    }
    [self changeValue];
}

- (void)changeValue{
    
    NSString * updatedText = [self.textField.text stringByReplacingOccurrencesOfString:@"," withString:@"."];

    float x = [updatedText floatValue];
    float y = [self.valueLabel.text floatValue];
    float ans;
    NSString * cur;
    if(toGel){
        ans = x * y;
        cur = @"GEL";
    }
    else{
        ans = x / y;
        cur = self.currencyLabel.text;
    }
    NSString *strFromInt = [NSString stringWithFormat:@"%.02f",ans];
    NSString *combined = [NSString stringWithFormat:@"%@ %@", strFromInt, cur];
    [self.resultLabel setText:combined];

}


-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

-(void)textFieldDidEndEditing:(UITextField *)sender
{
    [self changeValue];
    self.activeField = nil;
}

- (void) keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self popUpWithSize:keyboardSize];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // allow backspace
  /*  if (string.length)
    {
        [self changeValue];
        return YES;
    } */
    
    
    
    // verify max length has not been exceeded
    NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (updatedText.length > 9) // 4 was chosen for SSN verification
    {
        
        return NO;
    }
    else{
        int j = 0;
        updatedText = [updatedText stringByReplacingOccurrencesOfString:@"," withString:@"."];
        for(int i = 0; i < updatedText.length; i++){
            if([updatedText characterAtIndex:i] == '.')
                j++;
        }
        if(j > 1)
            return NO;
        
        NSString* NUMBERS_ONLY = @"1234567890,.";
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered]));
    }
    
    // only enable the OK/submit button if they have entered all numbers for the last four of their SSN (prevents early submissions/trips to authentication server)
  //  self.answerButton.enabled = (updatedText.length == 4);
  //  NSString *resultStr = [textField.text stringByReplacingCharactersInRange:range withString:string];

/*    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ChangeTextValue"
     object:self]; */
    return YES;
}



-(void)popUpWithSize:(CGSize)size
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, size.height + 20, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    /*
    UIScrollView *view1 = self.scrollView;
    CGPoint scrollPoint = CGPointMake(0.0, -500);
    [view1 setContentOffset:scrollPoint animated:YES];
    */
    CGPoint scrollPoint = CGPointMake(0.0, self.fromImage.bounds.size.height + 98);
    //[self.scrollView setContentOffset:scrollPoint animated:YES];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [self.scrollView setContentOffset:scrollPoint animated:NO];
                         [self.resultLabel setFrame:CGRectMake(self.resultLabel.bounds.origin.x, (self.resultLabel.bounds.origin.y + self.fromImage.bounds.size.height + 98 + self.resultLabel.bounds.size.height), self.resultLabel.bounds.size.width, self.resultLabel.bounds.size.height)];
                     }];
    
    /*
    CGRect newFrame = [self.textFieldSelected.superview convertRect:self.textFieldSelected.frame toView:self.view];
    //newFrame.origin.y = newFrame.origin.y;
    
    float viewY = (self.scrollView.frame.origin.y - self.scrollView.contentOffset.y) + self.textFieldSelected.frame.origin.y + self.textFieldSelected.frame.size.height + 20;
    float yValue = viewY - (self.view.frame.size.height - size.height);
    
    if (yValue > 0)
    {
        CGPoint scrollPoint = CGPointMake(0.0, self.scrollView.contentOffset.y + yValue);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
        [UIView animateWithDuration:0.25f
                         animations:^{
                             [self.scrollView setContentOffset:scrollPoint animated:NO];
                         }];
    }
    */
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [UIView animateWithDuration:0.25f
                         animations:^{
                             self.scrollView.contentInset = contentInsets;
                             self.scrollView.scrollIndicatorInsets = contentInsets;
                             [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                        }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"== %f", scrollView.contentOffset.y);
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"view_stat"])
    {
        WebViewController * webView = (WebViewController *)segue.destinationViewController;
        if([self.currencyLabel.text isEqualToString:@"USD"]){
            webView.idValue = 1;
        }
        else if([self.currencyLabel.text isEqualToString:@"EUR"]){
            webView.idValue = 2;
        }
        else if([self.currencyLabel.text isEqualToString:@"RUB"]){
            webView.idValue = 4;
        }
        else if([self.currencyLabel.text isEqualToString:@"GPB"]){
            webView.idValue = 3;
        }
        else if([self.currencyLabel.text isEqualToString:@"TRY"]){
            webView.idValue = 6;
        }
        else if([self.currencyLabel.text isEqualToString:@"AZN"]){
            webView.idValue = 9;
        }
        else if([self.currencyLabel.text isEqualToString:@"CNY"]){
            webView.idValue = 13;
        }
        
    }
}

-(void)homeHandler:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    WebViewController *webView = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    
    if([self.currencyLabel.text isEqualToString:@"USD"]){
        webView.idValue = 1;
    }
    else if([self.currencyLabel.text isEqualToString:@"EUR"]){
        webView.idValue = 2;
    }
    else if([self.currencyLabel.text isEqualToString:@"RUB"]){
        webView.idValue = 4;
    }
    else if([self.currencyLabel.text isEqualToString:@"GPB"]){
        webView.idValue = 3;
    }
    else if([self.currencyLabel.text isEqualToString:@"TRY"]){
        webView.idValue = 6;
    }
    else if([self.currencyLabel.text isEqualToString:@"AZN"]){
        webView.idValue = 9;
    }
    else if([self.currencyLabel.text isEqualToString:@"CNY"]){
        webView.idValue = 13;
    }
    
    [self presentViewController:webView animated:YES completion:nil];
}


/*
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    NSLog(@"%f", self.activeField.frame.origin.x);
    NSLog(@"%f", self.activeField.frame.origin.y);

    CGRect aRect = self.frontView.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
*/
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

@end
