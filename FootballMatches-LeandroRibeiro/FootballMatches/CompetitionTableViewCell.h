//
//  CompetitionTableViewCell.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompetitionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *team;
@property (weak, nonatomic) IBOutlet UIImageView *isFavorite;
@property (weak, nonatomic) IBOutlet UILabel *gamesPlayed;
@property (weak, nonatomic) IBOutlet UILabel *points;
@property (weak, nonatomic) IBOutlet UILabel *goalAverage;

@end

NS_ASSUME_NONNULL_END
