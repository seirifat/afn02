//
//  ViewController.m
//  afn02
//
//  Created by Rifat Firdaus on 6/9/15.
//  Copyright (c) 2015 Rifat Firdaus. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tfId;
@property (weak, nonatomic) IBOutlet UILabel *tfName;
@property (weak, nonatomic) IBOutlet UILabel *tfBirth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *string = @"http://dry-sierra-6832.herokuapp.com/api/people";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    NSLog(@"Start fetching");
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success here
        NSLog(@"Success");
        NSLog(@"%@",[NSString stringWithFormat:@"%@", (NSString *)responseObject]);
        NSDictionary *response = [responseObject objectAtIndex:0];
        NSLog(@"%@",response[@"id"]);
        int di = [response[@"id"] integerValue];
        _tfId.text = [@(di) stringValue];
        _tfName.text = response[@"name"];
        _tfBirth.text = [response valueForKey:@"birthdate"];
        [spinner stopAnimating];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [spinner stopAnimating];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Retrieve Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"oke"
                                                  otherButtonTitles:nil];
        [alertview show];
    }];
    [operation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
