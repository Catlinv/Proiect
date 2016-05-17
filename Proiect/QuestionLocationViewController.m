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

- (instancetype)init
{
    self = [super initWithNibName:@"QuestionBaseViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDistanceLeftLabel];
    [PROLocationManagerInstance setDelegate:self];
    [PROLocationManagerInstance startTracker];
}

#pragma mark - Private Methods

- (void)validateCoordinates:(CLLocationCoordinate2D)locationCoordinates{
    
    double distanceLeft = [PROUtils getAirDistancePointA:locationCoordinates pointB:CLLocationCoordinate2DMake([self.question.latitude doubleValue], [self.question.longitude doubleValue])];
    
    if (distanceLeft <= kMinimalValidationDistance){
        [self didAnswerCorrectly];
        self.distanceLeftLabel.hidden = YES;
    } else {
                                                                //TODO : (CS) Conversion distance in other method
        self.distanceLeftLabel.text = [NSString stringWithFormat:@"You have %f meters left", distanceLeft];
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
