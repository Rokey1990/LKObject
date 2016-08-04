
Pod::Spec.new do |s|
  s.name         = "LKObject"
  s.version      = "1.0.1"
  s.summary      = "An easy way to use model-to-viewmodel"
  s.homepage     = "http://www.baidu.com"
  s.license      = "MIT"
  s.author             = { "Rokey1990" => "992030970@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Rokey1990/LKObject.git", :tag => "#{s.version}" }
  s.source_files  = "src/**/*.{h,m}"
  s.requires_arc = true


end
