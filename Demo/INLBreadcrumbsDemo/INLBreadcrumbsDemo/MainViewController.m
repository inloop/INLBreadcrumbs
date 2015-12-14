//
//  MainViewController.m
//  RVBreadcrumbs
//
//  Created by Tomas Hakel on 18/10/2015.
//  Copyright © 2015 Inloop. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) NSArray * data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.data = @[@"One", @"Two", @"Three", @"Four", @"Five"];
	if (self.title == nil) {
		self.title = @"Zero";
	}
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
	cell.textLabel.text = self.data[indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"nextViewSegue" sender:self.data[indexPath.row]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	MainViewController * vc = segue.destinationViewController;
	vc.title = sender;
}

@end
