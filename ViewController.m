//
//  ViewController.m
//  YFLoginSystem
//
//  Created by 马顺 on 16/6/23.
//  Copyright © 2016年 马顺. All rights reserved.
//

#import "ViewController.h"
#define COLOR_RGB_HEX(HEX)      [UIColor colorWithRed:((float)((HEX & 0xFF0000) >> 16))/255.0 green:((float)((HEX & 0xFF00) >> 8))/255.0 blue:((float)(HEX & 0xFF))/255.0 alpha:1.0]
@interface ViewController () <UITextFieldDelegate>
{
	UITextField *_accoutTf;
	UITextField *_passwordTf;
	UIButton	*_loginButton;
}

@end

@implementation ViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	
	_accoutTf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
	_accoutTf.delegate = self;
	_accoutTf.backgroundColor = [UIColor redColor];
	_accoutTf.placeholder = @"账号";
	_accoutTf.clearButtonMode = UITextFieldViewModeWhileEditing;
	_accoutTf.keyboardType = UIKeyboardTypeEmailAddress;
	[self.view addSubview:_accoutTf];
	
	_passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 40)];
	_passwordTf.delegate = self;
	_passwordTf.backgroundColor = [UIColor redColor];
	_passwordTf.placeholder = @"密码";
	_passwordTf.keyboardType = UIKeyboardTypeEmailAddress;
	_passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
	_passwordTf.secureTextEntry = YES;
	[self.view addSubview:_passwordTf];
	
	_loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_loginButton.frame = CGRectMake(100, 240, 200, 40);
	_loginButton.backgroundColor = COLOR_RGB_HEX(0x47851d);
	[_loginButton setTitle:@"登录" forState:UIControlStateNormal];
	_loginButton.userInteractionEnabled = NO;
	[self.view addSubview:_loginButton];
	
		//给textfiled添加监听事件
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(jiantingNotification)
												 name:UITextFieldTextDidChangeNotification
											   object:_passwordTf];
}

- (void)jiantingNotification {
	if ([_passwordTf.text isEqualToString:@""]) {
		[self loginButtonNormalStatus];
	}else {
		[self loginButtonHighLightStatus];
	}
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSMutableString *newStr = [textField.text mutableCopy];
	[newStr replaceCharactersInRange:range
						  withString:string];
	if ([textField isEqual:_passwordTf]) {
		if ([_accoutTf.text length] == 0 || [newStr length] == 0) {
			[self loginButtonNormalStatus];
		}else {
			[self loginButtonHighLightStatus];
		}
	}else if ([textField isEqual:_accoutTf]){
		if ([_passwordTf.text length] == 0 || [newStr length] == 0) {
			[self loginButtonNormalStatus];
		}else {
			[self loginButtonHighLightStatus];
		}
	}
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	if ([textField isEqual:_passwordTf]) {
		if ([_accoutTf.text length] == 0 || [textField.text length] != 0) {
			[self loginButtonNormalStatus];
		}else {
			[self loginButtonHighLightStatus];
		}
	}else if ([textField isEqual:_accoutTf]) {
		if ([_passwordTf.text length] == 0 || [textField.text length] != 0) {
			[self loginButtonNormalStatus];
		}else {
			[self loginButtonHighLightStatus];
		}
	}
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	if ([textField isEqual:_passwordTf]) {
		if (textField.text.length == 0) {
			[self loginButtonNormalStatus];
		}else {
			[self loginButtonHighLightStatus];
		}
	}
}
- (void)loginButtonHighLightStatus {
	_loginButton.backgroundColor        = COLOR_RGB_HEX(0x23c609);
	[_loginButton setTitleColor:COLOR_RGB_HEX(0xffffff) forState:UIControlStateNormal];
	_loginButton.userInteractionEnabled = YES;
}

- (void)loginButtonNormalStatus {
	_loginButton.backgroundColor = COLOR_RGB_HEX(0x47851d);
	[_loginButton setTitleColor:COLOR_RGB_HEX(0xb4b4b4) forState:UIControlStateNormal];
	_loginButton.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
