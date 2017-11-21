//
//  GameObj.h
//  Starwars API
//
//  Created by Walter Gonzalez Domenzain on 08/11/17.
//  Copyright © 2017 Boletomovil. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GameObj
@end
@interface GameObj : JSONModel
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *away_name;
@property (strong, nonatomic) NSString *home_name;
@property (strong, nonatomic) NSString *away_logo;
@property (strong, nonatomic) NSString *home_logo;


//"time": "08:35 PM",
//"startTime": "07:35 PM",
//"away_name": "Águilas",
//"home_name": "Tomateros",
//"away_logo": "/assets/images/logo-team/mxc.png",
//"home_logo": "/assets/images/logo-team/cul.png"

@end
