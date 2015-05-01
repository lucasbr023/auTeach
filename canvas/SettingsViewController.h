//
//  SettingsViewController.h
//  canvas
//
//  Created by Natalia Souza on 4/30/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end

@interface SettingsViewController : UIViewController

@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;

@property CGFloat brush;
@property CGFloat opacity;

@property (weak, nonatomic) IBOutlet UILabel *brushControl;

@property (weak, nonatomic) IBOutlet UILabel *opacityControl;

@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;

@property (weak, nonatomic) IBOutlet UIImageView *opacityPreview;

@property (weak, nonatomic) IBOutlet UISlider *brushValueLabel;

@property (weak, nonatomic) IBOutlet UISlider *opacityValueLabel;

- (IBAction)sliderChanged:(id)sender;

- (IBAction)closeSettings:(id)sender;


@end
