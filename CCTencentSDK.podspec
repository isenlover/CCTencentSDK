Pod::Spec.new do |s|
  s.name         = "CCTencentSDK"
  s.version      = "1.0.0"
  s.summary      = "QQ和微信SDK"

  s.description  = <<-DESC
	QQ和微信SDK,保持最新版
                   DESC

  s.homepage     = "https://github.com/isenlover/CCTencentSDK"
  s.license      = "MIT"
  s.author       = { "iSen" => "ccdeveloper@163.com" }
  s.platform     = :ios,'8.0'

  s.source       = { :git => "https://github.com/isenlover/CCTencentSDK.git", :tag => "#{s.version}" }
  s.source_files = "CCTencentSDK/Classes/*.{h,m}", "CCTencentSDK/Classes/WechatSDK/*.{h,m}"
  #s.frameworks   = "CoreTelephony", "CoreGraphics", "SystemConfiguration", "Security"
  #s.vendored_framework = 'CCTencentSDK/Classes/QQSDK/CCTencentSDK.framework'
  #s.resource_bundles = {'Resources' => 'CCTencentSDK/Classes/QQSDK/TencentOpenApi_IOS_Bundle.bundle'}
  #s.libraries	 = "stdc++", "sqlite3", "iconv"
  #s.ios.vendored_libraries = 'CCTencentSDK/Classes/WechatSDK/libWeChatSDK.a'
  s.requires_arc = true
end
