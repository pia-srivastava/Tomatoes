//
//  MovieCell.h
//  RottenTomatoes
//
//  Created by Pia on 1/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *movieTitleLabel;
@property(nonatomic,weak) IBOutlet UILabel *synopsisLabel;
@property(nonatomic,weak) IBOutlet UILabel *castLabel;
@property(nonatomic,weak) IBOutlet UIImageView *posterImage;

@end
