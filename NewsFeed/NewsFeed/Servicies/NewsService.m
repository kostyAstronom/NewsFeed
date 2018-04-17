//
//  NewsService.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsService.h"
#import "NetworkManager.h"
#import "MockNetworkManager.h"
#import "NewsDatabaseManager.h"
#import "AppDelegate.h"

@interface NewsService ()

@property (nonatomic) id<NewsServiceProtocol> networkManager;
@property (nonatomic) NewsDatabaseManager *databaseManager;

@end

@implementation NewsService

- (id)init {
    
    if (self = [super init]) {
        self.networkManager = [NetworkManager new];
        //self.networkManager = [MockNetworkManager new];
        self.databaseManager = [[NewsDatabaseManager alloc] initWithManagedObjectContext:((AppDelegate *)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext];
    }
    return self;
    
}

- (void)getTopStoriesWithCompletion:(void (^)(NSArray<Story *> *story, NSError *))completionHandler {
    
    [self.databaseManager getTopStoriesWithCompletion:^(NSArray<Story *> *stories, NSError *error) {
        completionHandler(stories, error);
    }];
    
    [self.networkManager getTopStoriesWithCompletion:^(NSArray<Story *> *stories, NSError *error) {
        completionHandler(stories, error);
        [self.databaseManager save:stories];
    }];
    
}

@end
