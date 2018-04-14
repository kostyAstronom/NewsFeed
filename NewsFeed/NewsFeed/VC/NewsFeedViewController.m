//
//  NewsFeedViewController.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 05.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "StoryTableCell.h"
#import "SingleNewsViewController.h"
#import "NewsServiceFactory.h"

@interface NewsFeedViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray<Story *> *listOfStories;

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoryTableCell" bundle:nil] forCellReuseIdentifier:[StoryTableCell reuseIdentifier]];
    
    self.newsService = [NewsServiceFactory getService];
    self.listOfStories = [NSMutableArray new];
    
    [self.newsService getTopStoriesWithCompletion:^(NSArray<Story *> *stories, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.listOfStories = [stories copy];
            [self.tableView reloadData];
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfStories count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoryTableCell *cell = (StoryTableCell *)[tableView dequeueReusableCellWithIdentifier:[StoryTableCell reuseIdentifier]];
    
    Story *story = self.listOfStories[indexPath.row];
    
    cell.title.text = story.title;
    cell.by.text = story.by;
    
    cell.title.lineBreakMode = NSLineBreakByWordWrapping;
    cell.title.numberOfLines = 0;
    
    cell.by.lineBreakMode = NSLineBreakByWordWrapping;
    cell.by.numberOfLines = 0;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SingleNewsViewController *singleNewsViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleNewsViewController"];
    
    [self.navigationController pushViewController:singleNewsViewController animated:YES];
    
    singleNewsViewController.story = [self.listOfStories objectAtIndex:indexPath.row];
   
}

@end
