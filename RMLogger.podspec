Pod::Spec.new do |s|

  s.name         = "RMLogger"
  s.version      = "0.1"
  s.summary      = "Logs output to the console like NSLog but has some extra features like colors."
  s.description  = <<-DESC
                   RMLogger lets you easily create console log messages with signal colors! It also provides a simple way to log errors.
                   DESC
  s.homepage     = "https://github.com/packatino/RMLogger"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "Robert Mißbach"
  s.social_media_url   = "https://twitter.com/packatino"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/packatino/RMLogger.git", :tag => "0.1" }
  s.source_files  = "RMLogger/RMLogger", "RMLogger/RMLogger/**/*.{h,m}"

end
