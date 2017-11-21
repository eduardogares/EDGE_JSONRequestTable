//
//  WebServices.h
//  Starwars API
//
//  Created by Walter Gonzalez Domenzain on 08/11/17.
//  Copyright © 2017 Boletomovil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "GameObj.h"

@interface WebServices : NSObject<NSURLSessionDelegate>

+ (void)getGames:(NSString*)date completion:(void (^)(NSMutableArray *gamesArray)) handler;

@end
