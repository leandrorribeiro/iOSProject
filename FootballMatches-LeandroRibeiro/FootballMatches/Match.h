//
//  Match.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Match : NSObject

@property (strong, nonatomic, readonly) NSString *homeTeam;
@property (strong, nonatomic, readonly) NSNumber *homeGoals;
@property (strong, nonatomic, readonly) NSString *awayTeam;
@property (strong, nonatomic, readonly) NSNumber *awayGoals;
@property (strong, nonatomic, readonly) NSString *date;
@property (strong, nonatomic, readonly) NSString *status;
@property (strong, nonatomic, readonly) NSString *competition;
@property (strong, nonatomic, readonly) NSNumber *competitionID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
