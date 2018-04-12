//
//  StoryDB+CoreDataProperties.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 11.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//
//

#import "StoryDB+CoreDataProperties.h"

@implementation StoryDB (CoreDataProperties)

+ (NSFetchRequest<StoryDB *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"StoryDB"];
}

- (void)setupWithDictionary:(NSDictionary *)dictionary {
    
    self.author = dictionary[@"by"];
    self.identifier = [dictionary[@"id"] intValue];
    self.title = dictionary[@"title"];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [NSString stringWithFormat:@"%@.html", dictionary[@"id"]];
    path = [path stringByAppendingPathComponent:fileName];
    
    NSURL *storyURL = [NSURL URLWithString:dictionary[@"url"]];
    NSData *urlData = [NSData dataWithContentsOfURL:storyURL];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!fileExists) {
        [urlData writeToFile:path atomically:YES];
    }
    
    self.storedHtml = [NSURL URLWithString:path];
    
}

@dynamic storedHtml;
@dynamic author;
@dynamic identifier;
@dynamic title;

@end
