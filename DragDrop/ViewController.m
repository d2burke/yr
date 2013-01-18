//
//  ViewController.m
//  DragDrop
//
//  Created by Daniel Burke on 1/10/13.
//  Copyright (c) 2013 Daniel Burke. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController (){
    UIScrollView *userPanel;
    BOOL userPanelIsVisible;
    UIButton *myButton;
    UIButton *button2;
    UIView *otherView;
    UIView *otherView2;
    UITableView *myTable;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myTable = [[UITableView alloc] initWithFrame:self.view.bounds];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.backgroundColor = [UIColor clearColor];
    
    myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(10.f, 10.f, 90.f, 90.f);
    
    //[myButton setTitle:@"Press" forState:UIControlStateNormal];
    //[myButton setTitle:@"Gotcha!" forState:UIControlStateHighlighted];
    
    [myButton addTarget:self action:@selector(imageTouch:withEvent:) forControlEvents:UIControlEventTouchDown];
    [myButton addTarget:self action:@selector(imageMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [[myButton layer] setBorderWidth:5.f];
    [[myButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    UIImageView *scape1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    scape1.frame = CGRectMake(0.f, 0.f, 90.f, 90.f);
    [myButton addSubview:scape1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(10.f, 110.f, 90.f, 90.f);
    
    UIImageView *scape2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
    scape2.frame = CGRectMake(0.f, 0.f, 90.f, 90.f);
    [button2 addSubview:scape2];
    
    //[button2 setTitle:@"Press" forState:UIControlStateNormal];
    //[button2 setTitle:@"Gotcha!" forState:UIControlStateHighlighted];
    
    [button2 addTarget:self action:@selector(imageTouch:withEvent:) forControlEvents:UIControlEventTouchDown];
    [button2 addTarget:self action:@selector(imageMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [[button2 layer] setBorderWidth:5.f];
    [[button2 layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    userPanel = [[UIScrollView alloc] initWithFrame:CGRectMake(320.f, 0, 100.f, self.view.frame.size.height)];
    userPanel.backgroundColor = [UIColor whiteColor];
    
    otherView = [[UIView alloc] initWithFrame:CGRectMake(5.f, 5.f, 90.f, 90.f)];
    otherView.backgroundColor = [UIColor redColor];
    
    otherView2 = [[UIView alloc] initWithFrame:CGRectMake(100.f, 5.f, 90.f, 90.f)];
    otherView2.backgroundColor = [UIColor redColor];
    
    userPanelIsVisible = NO;
    
    //[self.view addSubview:myTable];
    [userPanel addSubview:otherView];
    [userPanel addSubview:otherView2];
    [self.view addSubview:userPanel];
    [self.view addSubview:myButton];
    [self.view addSubview:button2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(5.f, 5.f, 100.f, 100.f);
    
    [button setTitle:@"Press" forState:UIControlStateNormal];
    [button setTitle:@"Gotcha!" forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(imageTouch:withEvent:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(imageMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, cell.frame.size.width, cell.frame.size.height)];
    bg.backgroundColor = [UIColor grayColor];
    [cell addSubview:bg];
    [self.view sendSubviewToBack:bg];
    
    [cell addSubview:button];
    
    cell.textLabel.text = @"Test";
    cell.detailTextLabel.text = @"Subtitle";
    
    return cell;
}

#pragma mark Custom Methods

-(IBAction)imageMoved:(id)sender withEvent:(UIEvent *)event{
    UIButton *movedBtn = (UIButton *)sender;
    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    UIControl *control = sender;
    control.center = point;
    
    //NSLog(@"X: %f, Y: %f", point.x, point.y);
    
    CGRect buttonRect = [movedBtn convertRect:myButton.frame toView:[myButton superview]];
    CGRect otherRect = [otherView convertRect:otherView.frame toView:[myButton superview]];
    

    
    if(point.x > 300 && !userPanelIsVisible){
        [self toggleUserPanel:self];
    }
    else if(point.x > 300 && userPanelIsVisible){
        if(CGRectIntersectsRect(buttonRect, otherRect)){
            NSLog(@"Drop Now!");
        }
    }
    else if(point.x < 220.f && userPanelIsVisible){
        [self toggleUserPanel:self];
    }
    
    if(userPanelIsVisible){
    }
}

-(IBAction)imageTouch:(id)sender withEvent:(UIEvent *) event{
    UIButton *movedBtn = (UIButton *)sender;
    //NSLog(@"X: %f, Y: %f", movedBtn.frame.origin.x, movedBtn.frame.origin.y);
}

-(void)toggleUserPanel:(id)sender{
    //UIButton *myButton = (UIButton *)sender;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
  
    CGRect panelFrame = userPanel.frame;
    //CGRect viewFrame = self.view.frame;
    
    if(userPanelIsVisible){
        panelFrame.origin.x += 100.f;
        //viewFrame.origin.x += 100.f;
        userPanelIsVisible = NO;
    }
    else{
        panelFrame.origin.x -= 100.f;
        //viewFrame.origin.x -= 100.f;
        userPanelIsVisible = YES;
    }
    userPanel.frame = panelFrame;
    //self.view.frame = viewFrame;
    
    [UIView commitAnimations];
}

@end
