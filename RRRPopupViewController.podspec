
Pod::Spec.new do |s|

  s.name         = "RRRPopupViewController"
  s.version      = "0.0.1"
  s.summary      = "PopupViewController_swift"
  s.description  = <<-DESC
                    PopupViewController_swift
                   DESC
  s.homepage     = "https://github.com/RRRenJ/RRRPopupViewController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "RRRenJ" => "https://github.com/RRRenJ" }
  s.source       = { :git => "https://github.com/RRRenJ/RRRPopupViewController.git", :tag => s.version }


  s.source_files  = "RRRPopupViewController/*.swift"
  s.frameworks   = 'UIKit', 'Foundation'
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'

  


end
