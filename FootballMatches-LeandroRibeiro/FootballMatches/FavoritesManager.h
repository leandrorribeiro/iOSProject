//
//  FavoritesManager.h
//  FootballMatches
//
//  Created by Developer on 09/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteMO+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesManager : NSObject

+ (BOOL)createTeamWithName:(NSString *)teamName;

+ (NSArray <FavoriteMO *> *)allFavorites;

+ (BOOL)deleteFromFavorites: (NSString *)teamName;

@end

NS_ASSUME_NONNULL_END
