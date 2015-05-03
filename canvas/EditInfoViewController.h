//
//  EditInfoViewController.h
//  canvas
//
//  Created by Natalia Souza on 5/3/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end

@interface EditInfoViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtNome;

@property (weak, nonatomic) IBOutlet UITextField *txtSerie;

@property (weak, nonatomic) IBOutlet UITextField *txtIdade;

@property (nonatomic) int recordIDToEdit;

- (IBAction)saveInfo:(id)sender;

- (IBAction)atividades:(id)sender;

@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegate;


@end
