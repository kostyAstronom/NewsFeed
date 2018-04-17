//
//  MockNetworkManager.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "MockNetworkManager.h"

@implementation MockNetworkManager

- (void)getTopStoriesWithCompletion:(void(^)(NSArray<Story *> *stories, NSError *error))completionHandler {
    
    NSMutableArray<Story *> *stories = [NSMutableArray new];
    
    __block NSError *mockError;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    [self getTopStoriesIDsWithCompletion:^(NSArray<NSNumber *> *storiesIDs, NSError *error) {
        
        if (error || !storiesIDs ) {
            mockError = error;
            dispatch_group_leave(group);
            return;
        }
        for (NSNumber *storyID in storiesIDs) {
            dispatch_group_enter(group);
            [self getStoryByID:storyID withCompletion:^(Story *story, NSError *error) {
                
                if (story) {
                    [stories addObject:story];
                }
                if (error) {
                    mockError = error;
                }
                dispatch_group_leave(group);
                
            }];
        }
        dispatch_group_leave(group);
        
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if (completionHandler) {
            completionHandler([stories copy], mockError);
        }
        
    });
    
}

- (void)getTopStoriesIDsWithCompletion:(void(^)(NSArray<NSNumber *> *storiesIDs, NSError *error))completionHandler {
    
    NSMutableArray *tenTopStoriesIDs = [NSMutableArray new];
    
    NSError *mockError;
    
    NSString *topStoriesIDsPath = [NSBundle.mainBundle pathForResource:@"topStories" ofType:@"json"];
    NSData *topStoriesIDsData = [NSData dataWithContentsOfFile:topStoriesIDsPath options:NSDataReadingMappedIfSafe error:&mockError];
    NSDictionary *topStoriesIDsDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:topStoriesIDsData options:NSJSONReadingMutableContainers error:&mockError];
    
    if (mockError) {
        return;
    }
    if (topStoriesIDsDictionary) {
        NSArray<NSNumber *> *topStoriesIDs = (NSArray *)topStoriesIDsDictionary;
        for (int i = 0; i < 10 && i < topStoriesIDs.count; i++) {
            tenTopStoriesIDs[i] = topStoriesIDs[i];
        }
    }
    if (completionHandler) {
        completionHandler([tenTopStoriesIDs copy], mockError);
    }
    
}

- (void)getStoryByID:(NSNumber *)storyID withCompletion:(void (^)(Story *story, NSError *error))completionHahdler {
    
    Story *story = [Story new];
    
    NSError *error = nil;
    NSString *storyPath = [NSBundle.mainBundle pathForResource:[NSString stringWithFormat:@"%@", storyID] ofType:@"json"];
    NSData *storyData = [NSData dataWithContentsOfFile:storyPath options:NSDataReadingMappedIfSafe error:&error];
    NSMutableDictionary *storyDictionary = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:storyData options:NSJSONReadingMutableContainers error:&error];
    
    if (storyDictionary) {
        storyDictionary[@"storedHtml"] = [NSURL URLWithString:[NSString stringWithFormat:@"%@", storyDictionary[@"storedHtml"]]];
        [story setupWithDictionary:[storyDictionary copy]];
    }
    
    if (completionHahdler) {
        completionHahdler(story, error);
    }
    
}

@end
