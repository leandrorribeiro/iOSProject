//
//  CompetitionTableViewController.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompetitionTableViewController : UITableViewController
@property (strong, nonatomic) NSNumber *leagueID;
@property (weak, nonatomic) id  delegate;
@property (strong, nonatomic) NSString *homeTeam;
@property (strong, nonatomic) NSString *awayTeam;


@end

NS_ASSUME_NONNULL_END
