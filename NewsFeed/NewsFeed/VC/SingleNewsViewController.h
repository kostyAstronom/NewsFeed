//
//  SingleNewsViewController.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 11.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"
#import "StoryDB+CoreDataProperties.h"

@interface SingleNewsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic) StoryDB *story;

@end
