//
//  NewsFeedViewController.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 05.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsServiceProtocol.h"

@interface NewsFeedViewController : UIViewController

@property (nonatomic) id<NewsServiceProtocol> newsService;

@end
