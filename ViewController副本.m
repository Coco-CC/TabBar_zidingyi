//
//  ViewController.m
//  RealmGarden
//
//  Created by Xia on 16/8/9.
//  Copyright © 2016年 xiayong. All rights reserved.
//


#import "ViewController.h"


#import "XYReamlViewController.h"

#import "XYFindViewController.h"

#import "XYMoreViewController.h"

#import "XYMessageViewController.h"

#import "XYMainViewController.h"






#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong)UIButton *button;
@end

@implementation ViewController
@synthesize button;
#pragma mark- setup
-(void)setup
{
    //  添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@"JIA"] selectedImage:[UIImage imageNamed:@"JIA"]];
    //  UITabBarControllerDelegate 指定为自己
    self.delegate = self;
      //指定当前页——中间页
    self.selectedIndex=0;
      //设点button状态
    button.selected=YES;
    //  设定其他item点击选中颜色
    
}
#pragma mark - addCenterButton
// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
   
    
    //  设定button大小为适应图片
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    //  这个比较恶心  去掉选中button时候的阴影
    button.adjustsImageWhenHighlighted=NO;
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮
     */
    CGPoint center = self.tabBar.center;
    center.y = center.y - buttonImage.size.height/4;
    button.center = center;
    [self.view addSubview:button];
}

-(void)pressChange:(id)sender
{
    self.selectedIndex=2;
    button.selected=YES;
}

#pragma mark- TabBar Delegate

//  换页和button的状态关联上

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex==2) {
        button.selected=YES;
    }else
    {
        button.selected=NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance]setBackgroundColor:[UIColor blackColor]];
    
    [self setTabBarVC];
    [self setup];
    [self addButtonNotifation];
    self.tabBar.barTintColor = [UIColor blackColor];
}
//添加大圆按钮的通知
-(void)addButtonNotifation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonHidden) name:@"buttonNotifationCenter" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonNotHidden) name:@"buttonNotHidden" object:nil];
}
-(void)buttonNotHidden{
    button.hidden=NO;
}
-(void)buttonHidden{
    button.hidden=YES;
}
// 初始化所有子控制器
- (void)setTabBarVC{
    
    
    
    [self setTabBarChildController:[[XYReamlViewController alloc] init] title:@"境界" image:@"feijiangjie" selectImage:@"jingjie"];
    
    [self setTabBarChildController:[[XYFindViewController alloc]init] title:@"发现" image:@"iconfont-faxian" selectImage:@"iconfont-faxian1"];
    [self setTabBarChildController:[[XYMoreViewController alloc] init] title:@"" image:@"" selectImage:@""];
    //iconfont-xiaoxi-(1)1  iconfont-xiaoxi-(1)
    [self setTabBarChildController:[[XYMessageViewController alloc] init] title:@"圈子" image:@"feixiaoxi" selectImage:@"xiaoxi"];
    
    [self setTabBarChildController:[[XYMainViewController alloc] init] title:@"我的" image:@"iconfont-wode" selectImage:@"iconfont-wode1"];
}


// 添加tabbar的子viewcontroller
- (void)setTabBarChildController:(UIViewController*)controller title:(NSString*)title image:(NSString*)imageStr selectImage:(NSString*)selectImageStr{
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    
    nav.tabBarItem.title = title;
    
    
    nav.tabBarController.view.backgroundColor = [UIColor blackColor];
    
    nav.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGBA(220, 220, 220, 1.0)} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGBA(237, 204, 45, 1.0)} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
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
