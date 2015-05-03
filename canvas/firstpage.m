//
//  firstpage.m
//  canvas
//
//  Created by Natalia Souza on 5/1/15.
//  Copyright (c) 2015 Natalia Souza. All rights reserved.
//

#import "firstpage.h"
#import "DBManager.h"

@interface firstpage ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrAlunoInfo;

@property (nonatomic) int recordIDToEdit;


-(void)loadData;

@end

@implementation firstpage


- (IBAction)addNewRecord:(id)sender {
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    self.recordIDToEdit = -1;
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Make self the delegate and datasource of the table view.
    self.tblPeople.delegate = self;
    self.tblPeople.dataSource = self;

    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"alunos.sql"];
    [self loadData];
    
    
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from alunos";
    
    // Get the results.
    if (self.arrAlunoInfo != nil) {
        self.arrAlunoInfo = nil;
    }
    self.arrAlunoInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblPeople reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrAlunoInfo.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"nome"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"serie"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"idade"];
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.arrAlunoInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname], [[self.arrAlunoInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLastname]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"idade: %@", [[self.arrAlunoInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the record ID of the selected name and set it to the recordIDToEdit property.
    self.recordIDToEdit = [[[self.arrAlunoInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}
-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditInfoViewController *editInfoViewController = [segue destinationViewController];
    editInfoViewController.delegate = self;
    editInfoViewController.recordIDToEdit = self.recordIDToEdit;

}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        int recordIDToDelete = [[[self.arrAlunoInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from alunos where _id=%d", recordIDToDelete];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // Reload the table view.
        [self loadData];
    }
}
@end
