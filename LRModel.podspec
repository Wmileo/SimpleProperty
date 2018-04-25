Pod::Spec.new do |s|
  s.name         = "LRModel"
  s.version      = "0.2.2"
  s.summary      = "Property pick up"
  s.description  = <<-DESC
					 Easy to get property value
                   DESC

  s.homepage     = "https://github.com/Wmileo/SimpleProperty"
  s.license      = "MIT"
  s.author       = { "leo" => "work.mileo@gmail.com" }

  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/Wmileo/SimpleProperty.git", :tag => s.version.to_s }
  s.source_files = "SimpleProperty/LRModel/*.{h,m}"

  s.requires_arc = true
end
