//
//  Competition.m
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import "Competition.h"

@implementation Competition

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if (self) {
        _position = dictionary[@"position"];
        _playedGames = dictionary[@"playedGames"];
        _points = dictionary[@"points"];
        _ID = dictionary[@"team"][@"id"];
        _name = dictionary [@"team"][@"name"];
        _goalAverage = dictionary[@"goalDifference"];
        
    }
    
    return self;
}

@end
