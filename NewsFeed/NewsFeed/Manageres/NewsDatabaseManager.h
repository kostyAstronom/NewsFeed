//
//  NewsDatabaseManager.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryDB+MyExtension.h"
#import "DatabaseProtocol.h"

@interface NewsDatabaseManager : NSObject <DatabaseProtocol>

@property (nonatomic) NSManagedObjectContext *context;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
