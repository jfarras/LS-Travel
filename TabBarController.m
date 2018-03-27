#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarController* tabBarController = (UITabBarController*)self;
    UITabBar* tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    
    tabBarItem1.title = @"Take photo";
    tabBarItem2.title = @"Activities";
    tabBarItem3.title = @"Gallery";
    
    [tabBarItem1 setImage:[UIImage imageNamed:@"Camera-50.png"]];
    [tabBarItem2 setImage:[UIImage imageNamed:@"Inspection-50.png"]];
    [tabBarItem3 setImage:[UIImage imageNamed:@"Stack of Photos-50.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
