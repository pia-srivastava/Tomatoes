//
//  MoviesViewController.h
//  RottenTomatoes
//
//  Created by Pia on 1/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "Movie.h"
#import "MBProgressHUD.h"

@interface MoviesViewController : UITableViewController{
        MBProgressHUD *HUD;
}

@property(nonatomic, weak) Movie *movie;

@end
