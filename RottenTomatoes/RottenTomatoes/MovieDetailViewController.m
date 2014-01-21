//
//  MovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Anish Srivastava on 1/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
 
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.movie.title;
    self.synopsisLabel.text = self.movie.synopsis;
    self.castLabel.text = self.movie.cast;

    [self.posterImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.movie.image]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       self.posterImage.image = image;
                                       
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       
                                   }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
