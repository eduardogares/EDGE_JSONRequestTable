//
//  ViewController.m
//  Starwars API
//
//  Created by Walter Gonzalez Domenzain on 08/11/17.
//  Copyright © 2017 Boletomovil. All rights reserved.
//

#import "Home.h"
#import "GameCell.h"

@interface Home ()
@property (strong, nonatomic) NSMutableArray *games;

@end


@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initController];
}

- (void)initController {
    _games = [[NSMutableArray alloc] init];
    [self getGames];
    
    
    [self.tblMain reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//********************************************************************************************
#pragma mark                            Data methods
//********************************************************************************************
- (void)getGames{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [WebServices getGames:_tfDate.text completion:^(NSMutableArray *gamesArray) {
        
        if(gamesArray){
            [_games removeAllObjects];
            [_games addObjectsFromArray:gamesArray];
            
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [self.tblMain reloadData];
    }];
}

//********************************************************************************************
#pragma mark                            Action methods
//********************************************************************************************
- (IBAction)btnUpdatePressed:(id)sender {
    [self getGames];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _games.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    GameCell *cell = (GameCell *)[tableView dequeueReusableCellWithIdentifier:@"GameCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"GameCell" bundle:nil] forCellReuseIdentifier:@"GameCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
    }
    //Fill cell with info from arrays
    NSDictionary *gameObj = [_games objectAtIndex:indexPath.row];
    NSString *homeName = [gameObj objectForKey:@"home_name"];//matchInfo.home_name;
    NSString *awayName = [gameObj objectForKey:@"away_name"];//matchInfo.home_name;
    NSString *time = [gameObj objectForKey:@"time"];//matchInfo.home_name;
    
    cell.lblTeams.text       = [[homeName stringByAppendingString:@" VS "] stringByAppendingString:awayName];
    cell.lblTime.text        = time;
    
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //idx=(int)indexPath.row;
    NSLog(@"==>didSelectRowAtIndexPath %@",indexPath);
    
    //[self performSegueWithIdentifier:@"EdgeSegue" sender:self];
}


@end
