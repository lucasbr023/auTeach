//
//  ViewController.h
//  canvas
//
//  Created by Natalia Souza on 4/29/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@import AVFoundation;

#import "SettingsViewController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate> {
        
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    }


@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

- (IBAction)settings:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)reset:(id)sender;



- (IBAction)pencilPressed:(id)sender;


- (IBAction)eraserPressed:(id)sender;


@end

