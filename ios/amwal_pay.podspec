#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint amwal_pay.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
	s.name = 'amwal_pay'
	s.version = '0.0.1'
	s.summary = 'Amwal Pay flutter project.'
	s.description = <<-DESC
          A new Flutter plugin project.
	DESC
	s.homepage = 'https://www.amwal.tech/'
	s.license = { :file => '../LICENSE' }
	s.author = { 'Amwal Tech' => 'dev@amwal.tech' }
	s.source = { :path => '.' }
	s.source_files = 'Classes/**/*'
	s.public_header_files = 'Classes/**/*.h'
	s.dependency 'Flutter'
	s.dependency 'AmwalPayment', '~> 1.0.12'
	s.platform = :ios, '15.0'

	# Flutter.framework does not contain a i386 slice.
	s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
