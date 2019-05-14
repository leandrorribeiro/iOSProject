//
//  Competition.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Competition : NSObject

@property (strong, nonatomic, readonly) NSNumber *position;
@property (strong, nonatomic, readonly) NSNumber *playedGames;
@property (strong, nonatomic, readonly) NSNumber *points;
@property (strong, nonatomic, readonly) NSNumber *ID;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSNumber *goalAverage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
