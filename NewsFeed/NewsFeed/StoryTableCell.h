//
//  StoryTableCell.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 10.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *by;

+ (NSString *)reuseIdentifier;

@end
