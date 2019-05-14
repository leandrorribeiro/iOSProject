//
//  FootballDataAPI.m
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import "FootballDataAPI.h"

@implementation FootballDataAPI

- (void)getAllMatchesOfTheDay:(NSDate *)matchDay completionBlock:(void (^)(NSDictionary * , NSError * ))completion {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [NSString stringWithFormat:@"https://api.football-data.org/v2/matches?dateFrom=%@&dateTo=%@",[dateFormatter stringFromDate:matchDay], [dateFormatter stringFromDate:matchDay]];
    
    NSURL *url = [NSURL URLWithString:dateString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"c1d36da653a94eb79773016bfbe7e0ce" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil, error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil, jsonError);
            } else {
                
                NSArray *matchDictionaries = responseDictionary[@"matches"];
                NSMutableDictionary *matches = [NSMutableDictionary new];
                
                for (NSDictionary *matchDictionary in matchDictionaries) {
                    
                    Match *match = [[Match alloc] initWithDictionary:matchDictionary];
                    if ([matches objectForKey:match.competition]) {
                        [[matches objectForKey:match.competition] addObject:match];
                    }else {
                        [matches setObject:[NSMutableArray array] forKey:match.competition];
                        [[matches objectForKey:match.competition]addObject:match];
                    }
                }
                NSDictionary *matchesCopy = [NSDictionary dictionaryWithDictionary:matches];
                completion(matchesCopy, nil);
                
                
            }
        }
    }];
    
    [task resume];
}


- (void)getCompetitionsWithID:(NSNumber *)competitionID completionBlock:(void (^)(NSDictionary * , NSError * ))completion {
    
    
    NSString *competitionURL = [NSString stringWithFormat:@"https://api.football-data.org/v2/competitions/%@/standings/?standingType=TOTAL", competitionID];
    NSURL *url = [NSURL URLWithString:competitionURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"c1d36da653a94eb79773016bfbe7e0ce" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil, error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil, jsonError);
            } else {
                
                NSArray *competitionDictionaries = responseDictionary[@"standings"];
                NSDictionary *competitions = [NSDictionary dictionaryWithDictionary:competitionDictionaries[0]];
                NSArray *competitionTable =[competitions allValues];
                NSMutableDictionary *competitionPositions = [NSMutableDictionary new];
                for (NSDictionary *compDictionary in competitionTable[2]) {
                    Competition *competition = [[Competition alloc] initWithDictionary:compDictionary];
                    [competitionPositions setObject:competition forKey:competition.position];
                 }
                NSDictionary *competitionsCopy = [NSDictionary dictionaryWithDictionary:competitionPositions];
                completion(competitionsCopy, nil);

                }
                
            }
    }];                                  
    [task resume];
}

@end


