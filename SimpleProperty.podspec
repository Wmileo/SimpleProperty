Pod::Spec.new do |s|
  s.name         = "SimpleProperty"
  s.version      = "0.1.7"
  s.summary      = "Property pick up"
  s.description  = <<-DESC

					 Easy to get property value
                   DESC

  s.homepage     = "https://github.com/Wmileo/SimpleProperty"
  s.license      = "MIT"
  s.author             = { "leo" => "work.mileo@gmail.com" }

  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/Wmileo/SimpleProperty.git", :tag => s.version.to_s }
  s.source_files  = "SimpleProperty/SimpleProperty/*.{h,m}"

  s.requires_arc = true
end
