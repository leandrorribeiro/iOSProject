//
//  MatchTableViewController.m
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import "MatchTableViewController.h"
#import "Match.h"
#import "FootballDataAPI.h"
#import "MatchTableViewCell.h"
#import "CompetitionTableViewController.h"
#import "FavoritesManager.h"

@interface MatchTableViewController ()

@property (strong, nonatomic) NSDictionary *matches;
@property (strong, nonatomic) NSDate *matchDay;
@property (strong, nonatomic) NSString *homeTeam;
@property (strong, nonatomic) NSString *awayTeam;
@property (strong, nonatomic) IBOutlet UILabel *dateDisplayer;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;



@property (strong, nonatomic) FootballDataAPI *clientAPI;

@end

@implementation MatchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.matchDay) {
        self.matchDay = [NSDate date];
    }
    [self updateMatchViewControllerDateTexts:self.matchDay];
    self.datePicker.date = self.matchDay;
    
    self.clientAPI = [FootballDataAPI new];
    
    [FavoritesManager allFavorites];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.refreshControl beginRefreshing];
    [self updateModel];
}

- (void)updateModel {
    __weak MatchTableViewController *weakSelf = self;
    
    [self.clientAPI getAllMatchesOfTheDay:self.matchDay completionBlock:^(NSDictionary * matches, NSError * error) {
    
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else{
                weakSelf.matches = matches;
                    }            
            [weakSelf.refreshControl endRefreshing];
        }];
    }];

    
}

- (void)setMatches:(NSDictionary *)matches {
    _matches = matches;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.matches allValues].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self.matches allValues][section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.matches allKeys][section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell" forIndexPath:indexPath];
    Match *match = [self.matches allValues][indexPath.section][indexPath.row];
    
    cell.hour.text = [match.date substringWithRange:NSMakeRange(11, 5)];
    cell.homeTeam.text = match.homeTeam;
    cell.awayTeam.text = match.awayTeam;
    
    if ([match.homeGoals isKindOfClass:[NSNull class]]) {
        cell.goalsHomeTeam.text = @"0";
        cell.goalsAwayTeam.text = @"0";
    } else {
        cell.goalsHomeTeam.text = [NSString stringWithFormat:@"%@", match.homeGoals];
        cell.goalsAwayTeam.text = [NSString stringWithFormat:@"%@", match.awayGoals];
    }    
    
    cell.status.text = match.status;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Match *match = [self.matches allValues][indexPath.section][indexPath.row];
    [self performSegueWithIdentifier:@"Test" sender:match];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Test"]) {
        CompetitionTableViewController *competitionTable = segue.destinationViewController;
        Match *match = sender;
        competitionTable.delegate = self;
        competitionTable.leagueID = match.competitionID;
        competitionTable.title = match.competition;
        competitionTable.homeTeam = match.homeTeam;
        competitionTable.awayTeam = match.awayTeam;
    };
}


-(IBAction)changeOneDayOnDate:(UIButton *)button{
    
    NSDateComponents *dayComponentAdd = [[NSDateComponents alloc] init];
    dayComponentAdd.day = 1;
    NSDateComponents *dayComponentSubtract = [[NSDateComponents alloc] init];
    dayComponentSubtract.day = -1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponentAdd toDate:self.matchDay options:0];
    NSDate *previousDate = [theCalendar dateByAddingComponents:dayComponentSubtract toDate:self.matchDay options:0];
    
    
    if ([button.restorationIdentifier isEqualToString:@"AddOneDay"]) {
        self.matchDay = nextDate;
    }else if ([button.restorationIdentifier isEqualToString:@"SubtractOneDay"]){
        self.matchDay = previousDate;
    }
    
    [self updateMatchViewControllerDateTexts:self.matchDay];
    [self updateModel];
    
}

- (IBAction)refresh:(UIRefreshControl *)sender {
    
    if (sender.isRefreshing) {
        [self updateModel];
    }
}

-(void)updateMatchViewControllerDateTexts: (NSDate *)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *newDate = date;
    NSString *theDate = [dateFormat stringFromDate:newDate];
    self.dateDisplayer.text = theDate;
    self.datePicker.date = date;
}

-(IBAction)useDatePicker:(UIButton *)button {
    self.matchDay = self.datePicker.date;
    [self updateMatchViewControllerDateTexts:self.datePicker.date];
    [self updateModel];
}


//tenta forçar um sort aqui no match e vê no que dá

@end
