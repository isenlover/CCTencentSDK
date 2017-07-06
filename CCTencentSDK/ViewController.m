//
//  ViewController.m
//  CCTencentSDK
//
//  Created by 程策 on 2017/7/6.
//  Copyright © 2017年 程策. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>

#define QQAPIID @"101047344"
#define QQAPIKEY @"c24d9ee1b000c8dad09cfe413be319dc"

@interface ViewController () <TencentSessionDelegate>

@property (nonatomic, retain) TencentOAuth *tencentOAuth;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *logLabel;
@property (nonatomic, retain) NSArray *permissions;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAPIID andDelegate:self];
    _permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_GET_INFO,
                    kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_VIP_INFO, nil];
}

- (IBAction)QQLogin:(id)sender {
    [_tencentOAuth authorize:_permissions];
}

- (void)tencentDidLogin {
    _logLabel.text = @"登录成功";
    [_tencentOAuth getUserInfo];
    
}

- (void)getUserInfoResponse:(APIResponse *)response {
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        
        NSDictionary *userInfo = [response jsonResponse];
        NSString *nickName = userInfo[@"nickname"];
        _nameLabel.text = nickName;
        
    } else {
        NSLog(@"QQ auth fail ,getUserInfoResponse:%d", response.detailRetCode);
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled)
    {
        _logLabel.text = @"用户取消登录";
    }
    else
    {
        _logLabel.text = @"登录失败";
    }
}

- (void)tencentDidNotNetWork {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
