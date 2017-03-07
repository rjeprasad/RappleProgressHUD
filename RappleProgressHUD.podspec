Pod::Spec.new do |s|
s.name             = "RappleProgressHUD"
s.version          = "2.2.7"
s.summary          = "Flexible Activity & Progress indicator for Swift."

s.description      = <<-DESC
Flexible Activity & Progress indicator for Swift 3.
DESC

s.homepage         = "https://github.com/rjeprasad/RappleProgressHUD"
s.license          = 'MIT'
s.author           = { "Rajeev Prasad" => "rjeprasad@gmail.com" }
s.source           = { :git => "https://github.com/rjeprasad/RappleProgressHUD.git", :tag => s.version.to_s }

s.platform     = :ios, '8.0'
s.requires_arc = true
s.preserve_paths = 'LICENSE', 'README.md'
s.source_files = 'Pod/Classes/*'
end
