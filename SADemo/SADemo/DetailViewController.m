//
//  DetailViewController.m
//  SADemo
//
//  Created by zhuopin on 2019/7/24.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *button = [UIView new];
    button.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 45);
    button.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:button];
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(buttonTapAction)];
    [button addGestureRecognizer:tg];


    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 45);
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//    [button addTarget:self
//               action:@selector(buttonAction)
//     forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTapAction {
//    NSLog(@" tap action - %@", tap.delegate);
}

- (void)buttonAction {
    NSLog(@" button action ");
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
