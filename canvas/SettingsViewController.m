//
//  SettingsViewController.m
//  canvas
//
//  Created by Natalia Souza on 4/30/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//


#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize brush;
@synthesize opacity;

- (IBAction)closeSettings:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sliderChanged:(id)sender {
//    
//    self.brush == self.brushControl.value;
//    self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
//    
//    UIGraphicsBeginImageContext(self.brushPreview.frame.size);
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//} else if(changedSlider == self.opacityControl) {
//    
//    self.opacity = self.opacityControl.value;
//    self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
//    
//    UIGraphicsBeginImageContext(self.opacityPreview.frame.size);
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),20.0);
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, self.opacity);
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    self.opacityPreview.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

}
@end
