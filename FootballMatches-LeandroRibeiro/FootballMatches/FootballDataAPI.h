//
//  FootballDataAPI.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"
#import "Competition.h"

NS_ASSUME_NONNULL_BEGIN

@interface FootballDataAPI : NSObject

- (void)getCompetitionsWithID:(NSNumber *)competitionID completionBlock:(void (^)(NSDictionary * , NSError * ))completion;

- (void)getAllMatchesOfTheDay:(NSDate *)matchDay completionBlock:(void (^)(NSDictionary * , NSError * ))completion;

@end

NS_ASSUME_NONNULL_END
