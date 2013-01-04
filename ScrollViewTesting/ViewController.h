//
//  ViewController.h
//  ScrollViewTesting
//
//  Created by Sunil Kumar on 14/12/12.
//  Copyright (c) 2012 Sunil Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewAccessibilityDelegate>
{
    int widthForTwoViewsPortrait;
    int widthForTwoViewsLandscape;
    int firstPageLandscapeViewOriginX;
    int firstLoadFlag;
    
    int portraitWidth;
    int landscapeWidth;

}

@property (weak, nonatomic) IBOutlet UIScrollView *storyHolderScrollView;
@end
