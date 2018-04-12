//
//  StoryDB+CoreDataProperties.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 11.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//
//

#import "StoryDB+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StoryDB (CoreDataProperties)

+ (NSFetchRequest<StoryDB *> *)fetchRequest;
- (void)setupWithDictionary:(NSDictionary *)dictionary;

@property (nullable, nonatomic, copy) NSURL *storedHtml;
@property (nullable, nonatomic, copy) NSString *author;
@property (nonatomic) int32_t identifier;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
