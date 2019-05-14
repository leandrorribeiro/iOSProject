//
//  CompetitionTableViewController.m
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import "CompetitionTableViewController.h"
#import "Competition.h"
#import "FootballDataAPI.h"
#import "CompetitionTableViewCell.h"
#import "FavoritesManager.h"



@interface CompetitionTableViewController ()

@property (strong, nonatomic) NSDictionary  *team;
@property (strong, nonatomic) FootballDataAPI *clientAPI;
@property (strong, nonatomic) NSArray <FavoriteMO *> *favorites;


@end

@implementation CompetitionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clientAPI = [FootballDataAPI new];
    
    self.favorites = [FavoritesManager allFavorites];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateModel];
}

- (void)updateModel {
    __weak CompetitionTableViewController *weakSelf = self;
    
    [self.clientAPI getCompetitionsWithID:self.leagueID completionBlock:^(NSDictionary * team, NSError * error) {
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else{
                weakSelf.team = team;
            }
            
            [weakSelf.refreshControl endRefreshing];
        }];
    }];
}

- (void)setTeam:(NSDictionary *)team{
    _team = team;
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.team allKeys].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Posição  |  Nome        | Jogos   | Golos +/-  | Pontos"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CompetitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell" forIndexPath:indexPath];
    NSNumber *current = @(indexPath.row + 1);
    Competition  *team = [self.team objectForKey:current];
    
    cell.position.text = [NSString stringWithFormat:@"%@", team.position];
    cell.team.text = team.name;
    cell.points.text = [NSString stringWithFormat:@"%@", team.points];
    cell.gamesPlayed.text = [NSString stringWithFormat:@"%@", team.playedGames];
    cell.goalAverage.text = [NSString stringWithFormat:@"%@", team.goalAverage];
    if ([team.name isEqual:self.homeTeam] || [team.name isEqual:self.awayTeam])  {
        cell.backgroundColor = UIColor.yellowColor;
    }
    
    NSArray *favorites = [[NSArray alloc]initWithArray:[FavoritesManager.allFavorites valueForKey:@"name"]];
   
    if ([favorites containsObject:team.name]) {
        cell.isFavorite.image = [UIImage imageNamed:@"Favorite"];
    }else {
        cell.isFavorite.image = [UIImage imageNamed:@"NotFavorite"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *current = @(indexPath.row + 1);
    Competition *team = [self.team objectForKey:current];
    
    NSArray *favorites = [[NSArray alloc]initWithArray:[FavoritesManager.allFavorites valueForKey:@"name"]];
    if ([favorites containsObject:team.name]) {
        [self showAlertToRemoveTeam:team];
    }else{
        [self showAlertToAddTeam:team];
    }
    [self.tableView reloadData];
    [self updateModel];
    
}

- (void)showAlertToAddTeam: (Competition *)team {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Atenção!" message:@"Irá adicionar a equipa selecionada aos seus favoritos" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Confirmar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FavoritesManager createTeamWithName:team.name];
        [self.tableView reloadData];
        [self updateModel];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showAlertToRemoveTeam: (Competition *)team {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Atenção!" message:@"Irá remover a equipa selecionada dos seus favoritos" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Confirmar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [FavoritesManager deleteFromFavorites:team.name];
        [self.tableView reloadData];
        [self updateModel];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
