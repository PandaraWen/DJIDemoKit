Pod::Spec.new do |s|
	s.name = 'DJIDemoKit'
	s.version = '0.1'
	s.author = { 'kiwi-team' => 'www.kiwiinc.net' }
	s.license      = { :type => 'CUSTOM', :text => <<-LICENSE
****************************************************************************************************************************

DJIDemoKit is offered under KIWI's END USER LICENSE AGREEMENT. You can obtain the license from the below link:
http://www.kiwiinc.net

****************************************************************************************************************************
    LICENSE
  	}

	s.homepage = 'http://dev.kiwiinc.net/kiwi-team/DJIDemoKitDemo'
	s.source = { :git => 'git@dev.kiwiinc.net:kiwi-team/DJIDemoKitDemo.git', 
					:tag => "v#{s.version}"}
	s.summary = 'Awesome tool for creating a demo'
	s.platform = :ios
	s.ios.deployment_target = '10.0'

	s.module_name = 'DJIDemoKit'

	s.source_files = 'DJIDemoKit/*.swift'
	
	s.recource_bundle = {
		'DDKResource' => ['DJIDemoKit/*.xib', 'DJIDemoKit/.xcassets']
	}

	spec.dependency 'DJI-SDK-iOS', '4.2.2'
  	spec.dependency 'VideoPreviewer', :git => 'git@dev.kiwiinc.net:kiwi-team/DJI-Mobile-SDK-iOS.git'

	s.pod_target_xcconfig = {'ENABLE_BITCODE' => 'NO'}

end
