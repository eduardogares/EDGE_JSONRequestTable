//
//  WebServices.m
//  Starwars API
//
//  Created by Walter Gonzalez Domenzain on 08/11/17.
//  Copyright © 2017 Boletomovil. All rights reserved.
//

#import "WebServices.h"
#define nResponseCodeOK     200

#define nURLStarwarsPeople  @"people/"

@implementation WebServices

+ (void)getGames:(NSString*)date completion:(void (^)(NSMutableArray *gamesArray)) handler{
    
    NSMutableDictionary *diData = [[NSMutableDictionary alloc]init];
    
    //convert to json string
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:diData options:0 error:&error];
    
    if (!jsonData) {
        //Deal with error
    } else {
        NSString *strData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSURLSession *session = [self getSession];
        //_EDGE_ NSMutableURLRequest * request = [self getRequest:[nURLStarwarsAPI stringByAppendingString:nURLStarwarsPeople] forData:strData];
        NSString *query=@"";
        if(date.length>8){
            query=[nURLQuery stringByAppendingString:date];
        }
        else{
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            
            query=[nURLQuery stringByAppendingString:[dateFormatter stringFromDate:[NSDate date]]];
            NSLog(@"_EDGE_ URL querying today... ");
        }
        
        NSLog(@"_EDGE_ URL query:%@",query);
            
        
        
        NSMutableURLRequest * request = [self getRequest:query forData:strData];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(data!=nil){
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                
                
                if(jsonResponse!=nil){
                    NSMutableDictionary *gamesDicAll=jsonResponse[@"response"][@"games"];
                    NSString *keyName =[[gamesDicAll allKeys] objectAtIndex:0 ];
                    NSMutableArray *gamesList=[gamesDicAll objectForKey:keyName];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @try {
                            //NSLog(@"_EDGE_ response received %@",gamesList);
                            handler(gamesList);
                        }@catch (NSException *exception) {
                            handler(nil);
                        }
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(nil);
                    });
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil);
                });
            }
        }] resume];
    }
}



//**********************************************************************************************
#pragma mark                              Common methods
//**********************************************************************************************
+ (NSMutableURLRequest *) getRequest:(NSString *) url forData:(NSString *) data{
    
    NSURL *httpUrl = [NSURL URLWithString:url];
    NSLog(@"URL post = %@", url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
    if(data){
        //NSString * tempData = data;
        NSString *post = @"";//[[NSString alloc] initWithFormat:@"data=%@", tempData];
        NSLog(@"post parameters: %@",post);
        post = [post stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        [request setURL:httpUrl];
        [request setHTTPMethod:@"GET"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[@"Write your user agent name " stringByAppendingString:version] forHTTPHeaderField:@"User-Agent"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:httpUrl];
    }else{
        [request setURL:httpUrl];
        [request setHTTPMethod:@"GET"];
        //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[@"iOS Boletomovil " stringByAppendingString:version] forHTTPHeaderField:@"User-Agent"];
        [NSURLRequest requestWithURL:httpUrl];
    }
    
    return request;
    
    
}
//--------------------------------------------------------------------------------------------
+(NSURLSession *)getSession{
    
    // Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Configure Session Configuration
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPMaximumConnectionsPerHost:20];
    [sessionConfiguration setHTTPAdditionalHeaders:@{@"Accept" : @"application/json"}];
    
    return [NSURLSession sessionWithConfiguration:sessionConfiguration];
}
//*********************************************************************************************
#pragma mark                                alloc
//*********************************************************************************************
+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
    return nil;
}

@end
