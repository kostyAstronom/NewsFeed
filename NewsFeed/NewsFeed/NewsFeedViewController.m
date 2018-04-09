//
//  NewsFeedViewController.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 05.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "NetworkManager.h"

@interface NewsFeedViewController ()
@property (nonatomic) NSMutableArray *listOfStories;
@property (nonatomic) NetworkManager *networkManager;
@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.listOfStories = @[@"First", @"Second", @"Third", @"Fourth"];
    
    self.networkManager = [[NetworkManager alloc] init];
    [self.networkManager getTopStoriesWithCompletion:^(NSArray *stories, NSError *error) {
        
        for(Story *story in stories){
            [self.listOfStories addObject:story];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfStories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsFeedIdentifier = @"NewsFeedItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsFeedIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsFeedIdentifier];
    }
    
    cell.textLabel.text = [self.listOfStories objectAtIndex:indexPath.row];
    return cell;
}

@end
