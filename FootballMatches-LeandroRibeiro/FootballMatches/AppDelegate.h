//
//  AppDelegate.h
//  FootballMatches
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (BOOL)saveContext;


@end

