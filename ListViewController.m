//
//  ListViewController.m
//  dreamCatcher
//
//  Created by Grover Light on 3/23/15.
//  Copyright (c) 2015 learning, inc. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *titlesArray;
@property NSMutableArray *descriptionsArray;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = [NSMutableArray new];
    self.descriptionsArray = [NSMutableArray new];
}

-(void) presentDreamEntry

{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:(@"New Dream") message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Title";
    }];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Description";
    }];


    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {


        UITextField *textFieldOne = alertController.textFields[0];
        UITextField *textFieldTwo = alertController.textFields[1];

        [self.titlesArray addObject:textFieldOne.text];
        [self.descriptionsArray addObject:textFieldTwo.text];

        [self.tableView reloadData];


    }];

    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];

    [self presentViewController:alertController animated:true completion:nil];

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.titlesArray removeObjectAtIndex:indexPath.row];
    [self.descriptionsArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender

{

    [self presentDreamEntry];

}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    return YES;

}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath

{

    return true;

}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath

{

    NSString *titleItem = [self.titlesArray objectAtIndex:sourceIndexPath.row];
    [self.titlesArray removeObject:titleItem];
    [self.titlesArray insertObject:titleItem atIndex:destinationIndexPath.row];

    NSString *descriptionItem = [self.descriptionsArray objectAtIndex:sourceIndexPath.row];
    [self.descriptionsArray removeObject:descriptionItem];
    [self.descriptionsArray insertObject:descriptionItem atIndex:destinationIndexPath.row];


}


- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender


{

    if (self.editing)

    {

    self.editing = false;
    [self.tableView setEditing:false animated:true];
    sender.style = UIBarButtonItemStylePlain;
    sender.title = @"Edit";

    }

     else

     {

     self.editing = true;
     [self.tableView setEditing:true animated:true];
     sender.style = UIBarButtonItemStyleDone;
     sender.title = @"Edit";

     }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{

    return self.titlesArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{

    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.titleString = [self.titlesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailVC.descriptionString = [self.descriptionsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];



    }


@end
