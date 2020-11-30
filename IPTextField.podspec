#
# Be sure to run `pod lib lint IPTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IPTextField'
  s.version          = '0.1.0'
  s.summary          = 'Custom Text Field for instering ip addresses'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  IPTextField is a custom text field that enables users to enter ip address easily. The ip address gets validated while the user types.
                       DESC

  s.homepage         = 'https://github.com/Crystal-Pigeon/IPTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marianasamardzic' => 'marianasamardzic2@gmail.com' }
  s.source           = { :git => 'https://github.com/Crystal-Pigeon/IPTextField.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'IPTextField/Classes/**/*'
  
   s.resource_bundles = {
     'IPTextField' => ['IPTextField/Assets/**/*']
   }

end
