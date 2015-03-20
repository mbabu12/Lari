//
//  ViewController.m
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "InsideViewController.h"
#import "Reachability.h"
#import "GADBannerView.h"
#import "GADRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view, typically from a nib.
    arr = [[NSMutableArray alloc] init];
    count = 0;
    
    [self.logoView setBackgroundColor:[UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:63.0/255.0 green:179.0/255.0 blue:128.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.title = @"ვალუტის კურსი";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    [self.mainTable setSeparatorColor:[UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:1]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString * link = @"http://www.nbg.ge/rss.php?date=";
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    self.now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:self.now];
    NSString *fullLink = [NSString stringWithFormat:@"%@%@", link, dateString];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {

    
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"date"] != nil)
        {
            NSMutableArray * temp = [defaults objectForKey:@"data"];
        
            for(int i = 0; i < temp.count; i++){
                CellData * obj = [NSKeyedUnarchiver unarchiveObjectWithData:temp[i]];
                [arr addObject:obj];
            }
            self.now = [defaults objectForKey:@"date"];
        }
        else{
            NSData * data = [NSData dataWithContentsOfFile:@"rss.xml"];
            NSString *dateString = @"2015-02-10";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            self.now = [dateFormatter dateFromString:dateString];
            [self setData];
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            [parser setDelegate:self];
            [parser parse];
        }
        [self.mainTable reloadData];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd.MM.yy"];
        NSString *dateString = [format stringFromDate:self.now];
        [self.dataTitleLabel setText:[NSString stringWithFormat:@"მონაცემები ბოლოს განახლდა %@", dateString]];
        

    }else{
        
        
        GADBannerView *bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
        bannerView_.adUnitID = @"ca-app-pub-8635991207991290/2156233760";
        bannerView_.rootViewController = self;
        
        bannerView_.frame = CGRectMake( 0,
                                       self.view.frame.size.height - bannerView_.frame.size.height,
                                       bannerView_.frame.size.width,
                                       bannerView_.frame.size.height );
        
        bannerView_.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleRightMargin;
        
        
        // Enable test ads on simulators.
        [self.view addSubview:bannerView_];
        
        // Initiate a generic request to load it with an ad.
        GADRequest *request = [GADRequest request];
        request.testDevices = [NSArray arrayWithObjects:
                               GAD_SIMULATOR_ID,
                               nil];
        [bannerView_ loadRequest:request];

  
        [AppDelegate downloadDataFromURL:[NSURL URLWithString:fullLink] withCompletionHandler:^(NSData *data) {
            // Check if any data returned.
            if (data != nil){
                [self setData];
                NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
                [parser setDelegate:self];
                [parser parse];
            }
        }];
    }
   
 
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


/*
-(void)viewDidAppear:(BOOL)animated
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIDeviceOrientationPortrait] forKey:@"orientation"];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    appDelegate -> rotate = NO;
    
    
  //  [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: deviceOrientation] forKey:@"orientation"];
}
*/

-(void)viewDidLayoutSubviews
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        isInternet = NO;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        self.now = [defaults objectForKey:@"date"];
        NSString *dateString;
        if(self.now != nil){
        
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd.MM.yy"];
            dateString = [format stringFromDate:self.now];
        }
        else{
            dateString = @"10.02.15";
        }
        [self.dataTitleLabel setText:[NSString stringWithFormat:@"მონაცემები ბოლოს განახლდა %@", dateString]];
            }
    else{
        isInternet = YES;
        CGRect rect = self.dateView.frame;
        rect.origin.y -= 24;
        [self.dateView setFrame:rect];
    
        rect = self.mainTable.frame;
        rect.origin.y -= 24;
        rect.size.height +=24;
        [self.mainTable setFrame:rect];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"lari";
    
}
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
} */

-(void)setData{
    for(int i = 0; i < 7; i++){
        CellData * data = [CellData alloc];
        if(i == 0){
            data.name = @"USD";
            data.imageName = @"usa.png";
        }
        else if(i == 1){
            data.name = @"EUR";
            data.imageName = @"europe.png";
        }
        else if(i == 2){
            data.name = @"RUB";
            data.imageName = @"Ru.png";
        }
        else if(i == 3){
            data.name = @"GBP";
            data.imageName = @"United Kingdom.png";
        }
        else if(i == 4){
            data.name = @"TRY";
            data.imageName = @"Turkey.png";
        }
        else if(i == 5){
            data.name = @"AZN";
            data.imageName = @"Azerbaijan.png";
        }
        else if(i == 6){
            data.name = @"CNY";
            data.imageName = @"China.png";
        }
        [arr addObject:data];
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.elName = elementName;
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([self.elName isEqual: @"description"])
    {
        count++;
    
        if(count == 3){
            
            NSArray *myWords = [string componentsSeparatedByString:@"</tr><tr>"];
            NSString *st;
            NSArray *innerArray;
            CellData * data;
            for(int i = 0; i < myWords.count; i++)
            {
                st = myWords[i];
                
                for(int j = 0; j < arr.count; j++)
                {
                    data = ((CellData*)arr[j]);
                    if ([st rangeOfString:data.name options:NSCaseInsensitiveSearch].length > 0)
                    {
                        innerArray = [st componentsSeparatedByString:@"<td>"];
                        st = (NSString*)innerArray[3];
                        st = [st substringWithRange:NSMakeRange(0, st.length - 9)];
                        
                        NSString * img = (NSString*)innerArray[4];
                        NSString * plus;
                        if ([img rangeOfString:@"green"].length == 0) {
                            data.color = [UIColor colorWithRed:237.0/255.0 green:129.0/255.0 blue:139.0/255.0 alpha:1.0];
                            plus = @"-";
                        }
                        else {
                            data.color = [UIColor colorWithRed:63.0/255.0 green:179.0/255.0 blue:128.0/255.0 alpha:1.0];
                            plus = @"+";
                        }
                        
                        NSString * num = (NSString*)innerArray[5];
                        num = [num substringWithRange:NSMakeRange(0, num.length - 8)];
                        NSString *combined = [NSString stringWithFormat:@"%@%@", plus, num];
                        data.number = combined;
                        if([data.name isEqual:@"RUB"])
                        {
                            data.value = [NSString stringWithFormat:@"%.04f", [st floatValue]/100];
                        }
                        else if([data.name isEqual:@"CNY"])
                        {
                            data.value = [NSString stringWithFormat:@"%.04f", [st floatValue]/10];
                        }
                        else
                        {
                            data.value= st;
                        }
                    }
                }
            }
            
            NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:arr.count];
            for (CellData *objects in arr) {
                NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:objects];
                [archiveArray addObject:personEncodedObject];
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:archiveArray forKey:@"data"];
        
                
        
            [defaults setObject:self.now forKey:@"date"];
            [defaults synchronize];
            
        
            [self.mainTable reloadData];
            [parser abortParsing];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"view_cur"])
    {
        
        InsideViewController *insideView = (InsideViewController *)segue.destinationViewController;
        insideView.myValue = self.clicked;
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (IBAction)openChart:(id)sender {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MainViewCell";
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    CellData *data = [arr objectAtIndex:indexPath.row];
    
    [cell setCellData:data];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([indexPath row] == ([self.mainTable indexPathsForVisibleRows].count - 1)){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.activityIndicator stopAnimating];
            
        });
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewCell *cell = (MainViewCell *)[self.mainTable cellForRowAtIndexPath:indexPath];
   // [cell setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1]];
    NSString * name = [cell.currencyLabel text];
    for(int i = 0; i < 7; i++){
        CellData * temp = [arr objectAtIndex:i];
        if([temp.name isEqual:name]){
            self.clicked = [arr objectAtIndex:i];
        }
    }
    
 
    [self performSegueWithIdentifier:@"view_cur" sender:nil];
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    MainViewCell *cell = (MainViewCell *)[self.mainTable cellForRowAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1]];  //highlight colour
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
     MainViewCell *cell = (MainViewCell *)[self.mainTable cellForRowAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]]; //normal color
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
