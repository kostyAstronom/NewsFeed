//
//  NewsDatabaseManager.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsDatabaseManager.h"
#import "StoryDB+MyExtension.h"

@implementation NewsDatabaseManager

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    
    if (self = [super init]) {
        self.context = context;
    }
    return self;
    
}

- (void)getTopStoriesWithCompletion:(void (^)(NSArray<Story *> *, NSError *))completionHandler {
    
    NSMutableArray<Story *> *topStories = [NSMutableArray new];
    NSError *error = nil;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StoryDB"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:@selector(compare:)];
    [request setSortDescriptors:@[sort]];

    NSArray<StoryDB *> *results = [self.context executeFetchRequest:request error:&error];

    int numberOfStories = 0;
    for (int i = (int)results.count - 1; i > 0 && numberOfStories < 10; i--) {

        NSDictionary *dictionary = @{ @"by" : results[i].author,
                             @"descendants" : @"",
                                      @"id" : [NSString stringWithFormat:@"%d", results[i].identifier],
                                    @"kids" : @"",
                                   @"score" : @"",
                                    @"time" : [NSString stringWithFormat:@"%d", results[i].time],
                                   @"title" : results[i].title,
                                     @"url" : results[i].url };

        [topStories addObject:[[Story alloc] initWithDictionary:dictionary]];
        numberOfStories++;
    }

    if (completionHandler) {
        completionHandler(topStories, error);
    }
    
}

- (void)saveStory:(Story *)story {
    
    NSError *error = nil;
    NSArray *fetchResults = [self seartchStoryByID:story.storyID];

    if (fetchResults.count == 0) {

        StoryDB* storyDB = [NSEntityDescription insertNewObjectForEntityForName:@"StoryDB" inManagedObjectContext:self.context];
        storyDB.author = story.by;
        storyDB.title = story.title;
        storyDB.time = [story.time intValue];
        storyDB.url = story.url;
        storyDB.identifier = [story.storyID intValue];
        storyDB.storedHtml = story.storedHtml;

    }
    
    if (![self.context save:&error]) {
        NSLog(@"*** You story was not saved! ***");
        return;
    }
    
}

- (void)deleteStory:(Story *)story {
    
    NSError *error = nil;
    NSArray *fetchResults = [self seartchStoryByID:story.storyID];
    
    if (fetchResults.count > 0) {
        
        for(NSManagedObject *managedObject in fetchResults) {
            [self.context deleteObject:managedObject];
        }
        
    }
    
    if (![self.context save:&error]) {
        NSLog(@"*** You story was not deleted! ***");
        return;
    }
    
}

- (NSArray<NSFetchRequest *> *)seartchStoryByID:(NSNumber *)storyID {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"StoryDB"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"identifier == %@", storyID]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchResults = [self.context executeFetchRequest:request error:&error];
    
    if(!error) return fetchResults;
    
    NSLog(@"*** You story was not found! ***");
    return nil;
    
}

@end
