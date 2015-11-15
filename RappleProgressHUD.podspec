Pod::Spec.new do |s|
  s.name             = "RappleProgressHUD"
  s.version          = "1.0.2"
  s.summary          = "Prexible Activity Indicator / Progress indicator in swift."

  s.description      = <<-DESC
Prexible Activity Indicator / Progress indicator in swift 2.0.
                       DESC

  s.homepage         = "https://github.com/rjeprasad/RappleProgressHUD"
  s.license          = 'MIT'
  s.author           = { "Rajeev Prasad" => "rjeprasad@gmail.com" }
  s.source           = { :git => "https://github.com/rjeprasad/RappleProgressHUD.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*'
end
