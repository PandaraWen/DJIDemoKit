Pod::Spec.new do |s|
	s.name = 'DJIDemoKit'
	s.version = '0.9'
	s.author = { 'Pandara' => 'www.pandara.xyz' }
	s.license = 'MIT'
	s.homepage = 'https://github.com/PandaraWen/DJIDemoKit'
	s.source = { :git => 'https://github.com/PandaraWen/DJIDemoKit.git', :tag => "v#{s.version}"}
	s.summary = 'Awesome tool for creating a demo with DJISDK'
	s.platform = :ios
	s.ios.deployment_target = '10.0'

	s.module_name = 'DJIDemoKit'

	s.source_files = 'DJIDemoKit/*.swift'

	s.dependency 'DJI-SDK-iOS', '4.3.2'
	s.dependency 'SnapKit', '4.0'

	s.pod_target_xcconfig = {'ENABLE_BITCODE' => 'NO'}
end
