//
//  MovieDetailViewController.h
//  RottenTomatoes
//
//  Created by Anish Srivastava on 1/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController

@property(nonatomic, weak) Movie *movie;
@property(nonatomic,weak) IBOutlet UILabel *synopsisLabel;
@property(nonatomic,weak) IBOutlet UILabel *castLabel;
@property(nonatomic,weak) IBOutlet UIImageView *posterImage;

@end
