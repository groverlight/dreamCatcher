//
//  DetailViewController.m
//  dreamCatcher
//
//  Created by Grover Light on 3/24/15.
//  Copyright (c) 2015 learning, inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    self.textView.text = self.descriptionString;


}

@end
