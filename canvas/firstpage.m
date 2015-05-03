//
//  firstpage.m
//  canvas
//
//  Created by Natalia Souza on 5/1/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "firstpage.h"

@implementation firstpage


- (IBAction)addNewRecord:(id)sender {
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

@end
