//
//  QuestionLocationViewController.m
//  Proiect
//
//  Created by webteam on 11/05/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "QuestionLocationViewController.h"
#import "PROLocationManager.h"


@interface QuestionLocationViewController () <PROLocationManagerDelegate>

@property (strong, nonatomic) UILabel *distanceLeftLabel;

@end

@implementation QuestionLocationViewController

#pragma mark - Overwritten

- (instancetype)init
{
    self = [super initWithNibName:@"QuestionBaseViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (![self.question.isSolved boolValue]) {
        [self setupDistanceLeftLabel];
        [PROLocationManagerInstance setDelegate:self];
        [PROLocationManagerInstance startTracker];
    }
}

- (void)hideWorkingUI {
    self.distanceLeftLabel.hidden = YES;
}

#pragma mark - Private Methods

- (void)validateCoordinates:(CLLocationCoordinate2D)locationCoordinates{
    
    double distanceLeft = [PROUtils getAirDistancePointA:locationCoordinates pointB:CLLocationCoordinate2DMake([self.question.latitude doubleValue], [self.question.longitude doubleValue])];
    
    if (distanceLeft <= kMinimalValidationDistance){
        [self didAnswerCorrectly];
        self.distanceLeftLabel.hidden = YES;
    } else {
        [self displayDistanceLeft:distanceLeft];
    }
        
    
}

-(void)displayDistanceLeft:(double)distanceLeft{
    
    if (distanceLeft < 1000.0){
        self.distanceLeftLabel.text = [NSString stringWithFormat:@"You have %@ meters left", [NSString stringWithFormat:@"%.02f", distanceLeft]];
    }
    else{
        self.distanceLeftLabel.text = [NSString stringWithFormat:@"You have %@ kilometers left", [NSString stringWithFormat:@"%.02f", distanceLeft/1000.0]];
    }
}

#pragma mark - PROLocationDelegate

- (void)proLocationManager:(PROLocationManager *)locationManager sendLocation:(CLLocation *)location {
    if (location && ![self.question.isSolved boolValue])
        [self validateCoordinates:[location coordinate]];
}


#pragma mark - Private UI Methods

- (void)setupDistanceLeftLabel {
    
    self.distanceLeftLabel = [[UILabel alloc] initWithFrame: self.questionWorkingView.bounds];
    self.distanceLeftLabel.text = @"Getting Location";
    self.distanceLeftLabel.textAlignment = NSTextAlignmentCenter;
    self.distanceLeftLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.questionWorkingView addSubview:self.distanceLeftLabel];
}

@end
