//
//  Match.m
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import "Match.h"
#import "FavoritesManager.h"

@implementation Match

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if (self) {
        _homeTeam = dictionary[@"homeTeam"][@"name"];
        _homeGoals = dictionary[@"score"][@"fullTime"][@"homeTeam"];
        _awayTeam = dictionary[@"awayTeam"][@"name"];
        _awayGoals = dictionary[@"score"][@"fullTime"][@"awayTeam"];
        _date = dictionary[@"utcDate"];
        _status = dictionary[@"status"];
        _competition = dictionary[@"competition"][@"name"];
        _competitionID = dictionary[@"competition"][@"id"];
    }
    
    return self;
}




@end
