//
//  ViewController.m
//  CustomDynamicAlertView
//
//  Created by Joan Barrull Ribalta on 18/02/15.
//  Copyright (c) 2015 com.giria. All rights reserved.
//

#import "ViewController.h"
#import "CustomdinamicAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(UIButton *)sender {
    CustomdinamicAlertView *alert = [[CustomdinamicAlertView alloc] initWithFrame: CGRectMake(350, 420, 300, 200)];
    alert.frame = CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height);
    //alert.backgroundColor = [UIColor redColor];
    alert.tintColor = [UIColor redColor];
    
    [self.view addSubview: alert];
    
}

@end
