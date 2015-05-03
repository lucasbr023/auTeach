//
//  firstpage.h
//  canvas
//
//  Created by Natalia Souza on 5/1/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoViewController.h"

@interface firstpage : UIViewController <UITableViewDelegate, UITableViewDataSource, EditInfoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;


- (IBAction)addNewRecord:(id)sender;

@end
