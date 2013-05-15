//
//  ViewController.m
//  KissXMLSample
//
//  Created by hirai.yuki on 2013/01/29.
//  Copyright (c) 2013年 hirai.yuki. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "DDXML.h"
#import "DDXMLElement+Dictionary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.classmethod.jp/feed/"]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDate *startDate = [NSDate date];
        
        NSError *error = nil;
        
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:responseObject options:0 error:&error];
        if (!error) {
            NSDictionary *xml = [doc.rootElement convertDictionary];

            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:startDate];
            NSLog(@"実行時間 : %lf (sec)\n%@", interval, xml);
        } else {
            NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
