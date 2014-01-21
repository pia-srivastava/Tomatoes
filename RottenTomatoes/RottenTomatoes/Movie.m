//
//  Movie.m
//  RottenTomatoes
//
//  Created by Pia on 1/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Movie.h"

@implementation Movie



-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        self.cast = [self cast:dictionary[@"abridged_cast"]];
        self.image = [self image:dictionary[@"posters"]];
    }
    
    return self;
}

-(NSString *)cast:(NSArray* ) castArray{

    NSMutableString *completeCast =[NSMutableString string];
    for (NSDictionary *wholeCast in castArray) {

        [completeCast appendString:[wholeCast objectForKey:@"name"]];
        [completeCast appendString:@"   "];

    }
    NSLog(@"cast is %@", completeCast);
    return completeCast;
}

-(NSString *)image:(NSDictionary* ) imageArray{
    
    NSLog(@"imageArray is %@", imageArray);
    NSString *imageUrl = [NSString string];
    imageUrl =[imageArray objectForKey:@"original"];
    
    NSLog(@"imageUrl is %@", imageUrl);
    return imageUrl;
}

@end
