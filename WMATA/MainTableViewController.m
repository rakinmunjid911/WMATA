//
//  MainTableViewController.m
//  WMATA
//
//  Created by Rakin Munjid on 5/5/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController () {
    NSArray *theLines;
    NSMutableArray *stationsArray;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *lines = @"https://api.wmata.com/Rail.svc/json/jLines?api_key=6b700f7ea9db408e9745c207da7ca827";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:lines]];
    NSDictionary *dictionaryOfLines = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@",dictionaryOfLines);
    
    theLines = [dictionaryOfLines objectForKey:@"Lines"];
    
    stationsArray = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in theLines){
        sleep(2);
        NSString *strURL = [NSString stringWithFormat:@"https://api.wmata.com/Rail.svc/json/jStations?LineCode=%@&api_key=6b700f7ea9db408e9745c207da7ca827", [dict objectForKey:@"LineCode"]];
        NSData *dt = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
        NSDictionary *stationsDict = [NSJSONSerialization JSONObjectWithData:dt options:NSJSONReadingMutableContainers error:nil];
        
        [stationsArray addObject:[stationsDict objectForKey:@"Stations"]];
        
    }
    
    NSLog(@"%@",stationsArray);
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return theLines.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[theLines objectAtIndex:section] objectForKey:@"DisplayName"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sta = [stationsArray objectAtIndex:section];
    return sta.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[[stationsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
