Pod::Spec.new do |s|
  s.name             = 'IPTextField'
  s.version          = '1.0.0'
  s.summary          = 'Custom Text Field for instering ip addresses'

  s.description      = <<-DESC
  IPTextField is a custom text field that enables users to enter ip address easily. The ip address gets validated while the user types.
                       DESC

  s.homepage         = 'https://github.com/Crystal-Pigeon/IPTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marianasamardzic' => 'marianasamardzic2@gmail.com' }
  s.source           = { :git => 'https://github.com/Crystal-Pigeon/IPTextField.git', :branch => 'package' }

  s.ios.deployment_target = '9.0'
s.swift_version = '4.2'

  s.source_files = 'Sources/**/*.swift'
  
   s.resource_bundles = {
     'IPTextField' => ['Sources/IPTextField/Assets/**/*']
   }

end
