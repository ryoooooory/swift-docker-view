#
#  Be sure to run `pod spec lint DockerView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "DockerView"
  spec.version      = "0.0.1"
  spec.summary      = "DockerView like Mac Dock"
  spec.homepage     = "https://github.com/ryoooooory/swift-docker-view.git"
  spec.license        = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Ryo Oshima" => "gryooooooryg@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.swift_version  = "5.0"
  spec.source       = { :git => "https://github.com/ryoooooory/swift-docker-view.git", :tag => "#{spec.version}" }
  spec.source_files  = "DockerView", "DockerView/**/*.swift"
end
