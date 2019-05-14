//
//  MatchTableViewCell.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UILabel *homeTeam;
@property (weak, nonatomic) IBOutlet UILabel *goalsHomeTeam;
@property (weak, nonatomic) IBOutlet UILabel *goalsAwayTeam;
@property (weak, nonatomic) IBOutlet UILabel *awayTeam;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

NS_ASSUME_NONNULL_END
