Pod::Spec.new do |s|
  	s.name         		= "JBPerformanceLogger"
 	s.version      		= "1.0.0"
  	s.summary      		= "Performance logger suitable for measuring number of frames per second in iOS applications."
  	s.homepage     		= "https://github.com/josipbernat/JBPerformanceLogger"
  	s.license      		= { :type => "MIT", :file => "LICENSE" }
  	s.author            = { "Josip Bernat" => "josip.bernat@gmail.com" }
  	s.social_media_url	= "http://twitter.com/josipbernat"
  	s.platform     		= :ios, "7.0"
  	s.source       		= { :git => "https://github.com/josipbernat/JBPerformanceLogger.git", :tag => "v1.0.0" }
  	s.source_files  	= 'JBPerformanceLogger/JBPerformanceLogger/**/*.{h,m}'
   	s.requires_arc 		= true
	s.dependency 		"PureLayout"
end