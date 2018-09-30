Pod::Spec.new do |s|
s.name             = "RappleProgressHUD"
s.version          = "3.0.4"
s.summary          = "Activity & Progress indicator for Swift."

s.description      = <<-DESC
Flexible & user-friendly Activity & Progress indicator for Swift 4.2.
DESC

s.homepage         = "https://github.com/rjeprasad/RappleProgressHUD"
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { "Rajeev Prasad" => "rjeprasad@gmail.com" }
s.source           = { :git => "https://github.com/rjeprasad/RappleProgressHUD.git", :tag => s.version.to_s }

s.swift_version = '4.2'

s.ios.deployment_target = '10.0'
s.source_files = 'Pod/Classes/*'
end
