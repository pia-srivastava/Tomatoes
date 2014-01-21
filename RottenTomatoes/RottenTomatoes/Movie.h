//
//  Movie.h
//  RottenTomatoes
//
//  Created by Pia on 1/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *cast;
@property (nonatomic, strong) NSString *image;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
