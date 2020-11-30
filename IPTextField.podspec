#
#  Be sure to run `pod spec lint IPTextField.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.

Pod::Spec.new do |spec|

  spec.name         = "IPTextField"
  spec.version      = "0.0.2"
  spec.summary      = "Custom Text Field for instering ip addresses"
  spec.description  = <<-DESC 
IPTextField is a custom text field that enables users to enter ip address easily. The ip address gets validated while the user types.
                   DESC

  spec.homepage     = "https://github.com/Crystal-Pigeon/IPTextField"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Mariana Samardzic" => "marianasamardzic2@gmail.com" }

  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/Crystal-Pigeon/IPTextField.git", :tag => "#{spec.version}" }

  spec.source_files  = 'IPTextField/**/*.{h,m}'

end
