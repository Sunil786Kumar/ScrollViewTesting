//
//  ViewController.m
//  ScrollViewTesting
//
//  Created by Sunil Kumar on 14/12/12.
//  Copyright (c) 2012 Sunil Kumar. All rights reserved.
//

#import "ViewController.h"
#import "FirstLandscapeContainer.h"
#import "SecondLandscapeContainer.h"
#import "FirstPortraitContainer.h"
#import "SecondPortraitContainer.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    firstPageLandscapeViewOriginX = 0;
    firstLoadFlag = 0;
    widthForTwoViewsLandscape = 548; //landscape
    //widthForTwoViewsPortrait = 320; //portrait
    
    
    self.storyHolderScrollView.delegate = self;
    [self findDeviceOrientation];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (self.storyHolderScrollView.contentOffset.x == self.storyHolderScrollView.contentSize.width - self.storyHolderScrollView.frame.size.width)
    {
        NSLog(@"Hapened");
        portraitWidth += 320;
        landscapeWidth += 568;
        
        //NSLog(@"PORTRAIT width is %i and LANDSCAPE is %i",portraitWidth,landscapeWidth);
        
       
        
         //firstPageLandscapeViewOriginX = self.storyHolderScrollView.contentSize.width;
        
         //self.storyHolderScrollView.contentSize = CGSizeMake(self.storyHolderScrollView.contentSize.width + widthForTwoViewsLandscape  , [self.storyHolderScrollView bounds].size.height);
        //NSLog(@"first load flag is %i",firstLoadFlag);
        
        [self findDeviceOrientation];
        
        
        
        
        // [self setUpPaginationLabel];
        
    }
    
}

-(void)setUpPortraitView
{
    NSLog(@"Portrait called");
    FirstPortraitContainer *firstPortrait = [[FirstPortraitContainer alloc]initWithNibName:@"FirstPortraitContainer" bundle:nil];
    firstPortrait.view.frame = CGRectMake(firstPageLandscapeViewOriginX, 0, firstPortrait.view.frame.size.width, firstPortrait.view.frame.size.height);
    [self.storyHolderScrollView addSubview:firstPortrait.view];
    
    SecondPortraitContainer *secondPortrait = [[SecondPortraitContainer alloc]initWithNibName:@"SecondPortraitContainer" bundle:nil];
    secondPortrait.view.frame = CGRectMake(firstPageLandscapeViewOriginX+firstPortrait.view.frame.size.width, 0, secondPortrait.view.frame.size.width, firstPortrait.view.frame.size.height);
    [self.storyHolderScrollView addSubview:secondPortrait.view];
    
    self.storyHolderScrollView.frame = CGRectMake(0, 0, firstPortrait.view.frame.size.width, [self.storyHolderScrollView bounds].size.height);
    if(firstLoadFlag == 0){
    self.storyHolderScrollView.contentSize = CGSizeMake(firstPageLandscapeViewOriginX+firstPortrait.view.frame.size.width + secondPortrait.view.frame.size.width,[[UIScreen mainScreen]bounds].size.height);
        firstLoadFlag = 1;
    }
}
-(void)setUpLandscapeView
{
    NSLog(@"Landscape called");
    FirstLandscapeContainer *firstLandscape = [[FirstLandscapeContainer alloc]initWithNibName:@"FirstLandscapeContainer" bundle:nil];
    firstLandscape.view.frame = CGRectMake(landscapeWidth, firstLandscape.view.frame.origin.y, firstLandscape.view.frame.size.width, firstLandscape.view.frame.size.height);
    NSLog(@"Lansscape width is %i",landscapeWidth);
    [self.storyHolderScrollView addSubview:firstLandscape.view];
    
    NSLog(@"Landscape width is %f",firstLandscape.view.frame.size.width);
    
    SecondLandscapeContainer *secondLandscape = [[SecondLandscapeContainer alloc]initWithNibName:@"SecondLandscapeContainer" bundle:nil];
    secondLandscape.view.frame = CGRectMake(landscapeWidth +firstLandscape.view.frame.size.width, 0, secondLandscape.view.frame.size.width, secondLandscape.view.frame.size.height);
    [self.storyHolderScrollView addSubview:secondLandscape.view];
    
    
   
    if(firstLoadFlag == 0){
        
    self.storyHolderScrollView.contentSize = CGSizeMake(firstLandscape.view.frame.size.width + secondLandscape.view.frame.size.width,[[UIScreen mainScreen]bounds].size.height);
        firstLoadFlag = 1;
    }
    else
    {
        self.storyHolderScrollView.contentSize = CGSizeMake(landscapeWidth + widthForTwoViewsLandscape  , [self.storyHolderScrollView bounds].size.height);
    }
    self.storyHolderScrollView.frame = CGRectMake(0, 0, firstLandscape.view.frame.size.width, firstLandscape.view.frame.size.height);
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self findDeviceOrientation];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
    
}

-(void)findDeviceOrientation
{
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
   
    
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationUnknown)
    {
        
        if([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait ||
           [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown)
        {
            
            [self setUpPortraitView];
            
        }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight ||
                 [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft)
            
        {
            
            [self setUpLandscapeView];
            
        }
        
    }
    
    
    if( [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait ||
       [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
    {
        
        [self setUpPortraitView];
        
    }
    if( [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight ||
       [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        
        [self setUpLandscapeView];
        
    }
    
}



@end
