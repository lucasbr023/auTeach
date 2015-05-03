//
//  EditInfoViewController.m
//  canvas
//
//  Created by Natalia Souza on 5/3/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "EditInfoViewController.h"
#import "DBManager.h"

@interface EditInfoViewController ()

@property (nonatomic, strong) DBManager *dbManager;

-(void)loadInfoToEdit;


@end

@implementation EditInfoViewController

-(void)loadInfoToEdit{
    // Create the query.
    NSString *query = [NSString stringWithFormat:@"select * from alunos where _id=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the textfields.
    self.txtNome.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nome"]];
    self.txtSerie.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"serie"]];
    self.txtIdade.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"idade"]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Make self the delegate of the textfields.
    self.txtNome.delegate = self;
    self.txtSerie.delegate = self;
    self.txtIdade.delegate = self;
    
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"alunos.sql"];
    

    // Check if should load specific record for editing.
    if (self.recordIDToEdit != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - IBAction method implementation

- (IBAction)saveInfo:(id)sender {
    // Prepare the query string.
    // If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
    NSString *query;
    if (self.recordIDToEdit == -1) {
        query = [NSString stringWithFormat:@"insert into alunos values(null, '%@', '%@', %d)", self.txtNome.text, self.txtSerie.text, [self.txtIdade.text intValue]];
    }
    else{
        query = [NSString stringWithFormat:@"update alunos set nome='%@', serie='%@', idade=%d where _id=%d", self.txtNome.text, self.txtSerie.text, self.txtIdade.text.intValue, self.recordIDToEdit];
    }
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

- (IBAction)atividades:(id)sender {
}


@end
