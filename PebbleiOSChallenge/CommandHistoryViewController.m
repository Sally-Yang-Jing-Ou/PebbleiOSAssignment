//
//  CommandHistoryViewController.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "CommandHistoryViewController.h"
#import "CommandHistoryTableViewCell.h"
#import "MainTabBarController.h"

static NSString * const CommandHistoryTableViewCellIdentifier = @"CommandHistoryTableViewCell";

@interface CommandHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *commandTableView;

@end

@implementation CommandHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commandTableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:NewCommandNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateData {
    [self.commandTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.delegate numberOfCommandsInCommandHistory];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommandHistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CommandHistoryTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[CommandHistoryTableViewCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setRGBColor:[self.delegate rgbColorAtIndexInCommandHistory:indexPath.row]];
    cell.commandSelected = [self.delegate isColorSelectedInCommandHistoryAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate commandHistoryDidToggleRGBColorAtIndex:indexPath.row];
    
    [(CommandHistoryTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] setCommandSelected:[_delegate isColorSelectedInCommandHistoryAtIndex:indexPath.row]];
}

@end
