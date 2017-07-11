//
//  ViewController.m
//  CCTencentSDK
//
//  Created by 程策 on 2017/7/6.
//  Copyright © 2017年 程策. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

#define QQAPIID @"101047344"
#define QQAPIKEY @"c24d9ee1b000c8dad09cfe413be319dc"

#define WECHATID @"wx2b2020463846d5b4"
#define WECHATSECRET @"7a483a7e4d7d6785e78a0f2716f7843c"

@interface ViewController () <TencentSessionDelegate, WXApiDelegate>

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

- (IBAction)WeChatLogin:(id)sender {
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    [WXApi sendReq:req];
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

#pragma mark - wechatDelegate
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req {
    
}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp {
    SendAuthResp *authResp = (SendAuthResp *)resp;
    if (authResp.errCode == 0) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
