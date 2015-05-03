//
//  EditInfoViewController.h
//  canvas
//
//  Created by Natalia Souza on 5/3/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtNome;

@property (weak, nonatomic) IBOutlet UITextField *txtSerie;

@property (weak, nonatomic) IBOutlet UITextField *txtIdade;


- (IBAction)saveInfo:(id)sender;


@end
