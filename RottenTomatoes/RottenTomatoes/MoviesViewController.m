//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Pia on 1/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "Reachability.h"
#import "YRDropdownView.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface MoviesViewController ()
@property (nonatomic, strong) NSMutableArray *movies;
-(void)reload;
- (BOOL) connectedToNetwork;
-(BOOL) checkInternet;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
-(void)refreshView:(UIRefreshControl *)refresh;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reload];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Hang on while we load ...";
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(doSomeFunkyStuff) onTarget:self withObject:nil animated:YES];
    
    self.title = @"Movies";
    self.movies = [NSMutableArray array];
	
    //Refresh Control
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
}

- (void)doSomeFunkyStuff {
    float progress = 0.0;
    while (progress < 1.0) {
        progress += 0.01;
        HUD.progress = progress;
        usleep(50000);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"am in cellForRowAtIndexPath");
    
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movie = self.movies[indexPath.row];
    
    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = movie.cast;
    
    __weak UITableViewCell *weakCell = cell;
    [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:movie.image]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       weakCell.imageView.image = image;
                                       
                                       //only required if no placeholder is set to force the imageview on the cell to be laid out to house the new image.
                                       //if(weakCell.imageView.frame.size.height==0 || weakCell.imageView.frame.size.width==0 ){
                                       [weakCell setNeedsLayout];
                                       //}
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       
                                   }];
    return cell;
}



#pragma mark - Private Methods


- (BOOL) connectedToNetwork
{
	Reachability *r = [Reachability reachabilityWithHostName:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}

-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
	if([self connectedToNetwork] != YES)
	{
        [YRDropdownView showDropdownInView:self.view
                                     title:@"Network Error"
                                    detail:@"No network connection found. An internet connection is required for htis application to work"];
        //		[self showMessage: @"No network connection found. An Internet connection is required for this application to work"
        //				withTitle:@"No Network Connectivity!"];
		return NO;
	}
	else {
		return YES;
	}
}

-(void)reload{
    NSLog(@"am in reload");
    
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *theMovies = [object objectForKey:@"movies"];
        
        for (NSDictionary *aMovie in theMovies) {
            Movie *movie = [[Movie alloc]initWithDictionary:aMovie];
            [self.movies addObject:movie];
        }
        
        [self.tableView reloadData];
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    MoviesViewController *moviesViewController = (MoviesViewController *)segue.destinationViewController;
    moviesViewController.movie = movie;
}

-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
    // custom refresh logic would be placed here...
    [self reload];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}


@end
