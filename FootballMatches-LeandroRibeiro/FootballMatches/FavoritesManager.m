//
//  FavoritesManager.m
//  FootballMatches
//
//  Created by Developer on 09/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import "FavoritesManager.h"
#import "AppDelegate.h"

@implementation FavoritesManager //ve se queres por a competiçao para fazer um sort por competicao

+ (BOOL)createTeamWithName:(NSString *)teamName {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    FavoriteMO *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:context];
    favorite.name = teamName;
    
    return [appDelegate saveContext];
}

+ (NSArray<FavoriteMO *> *)allFavorites {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *teamsFetch = [FavoriteMO fetchRequest];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    teamsFetch.sortDescriptors = @[nameSort];
    
    NSArray <FavoriteMO *> *teams = [context executeFetchRequest:teamsFetch error:nil];
    return teams;
}

+ (BOOL)deleteFromFavorites: (NSString *)teamName {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [FavoriteMO fetchRequest];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",teamName]; 
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *items = [context executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *managedObject in items){
        [context deleteObject:managedObject];
    }
    
    return [appDelegate saveContext];
}


    


@end
