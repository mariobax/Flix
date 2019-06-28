//
//  TrailerViewController.m
//  Flix
//
//  Created by mariobaxter on 6/28/19.
//  Copyright © 2019 mariobaxter. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property NSArray *data;
@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@", self.movie);
    
    [self loadTrailerData];
    
}

- (void) loadTrailerData {
    NSString *baseURLString = @"https://api.themoviedb.org/3/movie/";
    NSString *idURLString = [NSString stringWithFormat:@"%@", self.movie[@"id"]];
    NSString *restOfURLString = @"/videos?language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
    NSString *fullTrailerURLString = [[baseURLString stringByAppendingString:idURLString] stringByAppendingString:restOfURLString];
    NSURL *trailerURL = [NSURL URLWithString:fullTrailerURLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:trailerURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // If there was an error
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        // If there was no error retrieving API information
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.data = dataDictionary[@"results"];
        }
        NSLog(@"%@", self.data);
        
        NSString *baseURString = @"https://www.youtube.com/watch?v=";
        NSString *key = self.data[0][@"key"];
        NSString *fullTrailerURL = [baseURString stringByAppendingString:key];
        // Convert the url String to a NSURL object.
        NSURL *url = [NSURL URLWithString:fullTrailerURL];
        // Place the URL in a URL Request.
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        // Load Request into WebView.
        [self.webView loadRequest:request];
        
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
