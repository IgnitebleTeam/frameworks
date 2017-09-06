Pod::Spec.new do |s|  
    s.name              = 'IgnitebleIccSDK'
    s.version           = '1.1.1'
    s.summary           = 'Igniteble ICC'
    s.homepage          = 'http://example.com/'

    s.author            = { 'Name' => 'sdk@example.com' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :path => './IngitebleIccSDK.zip' }

    #s.ios.deployment_target = '8.0'
    #s.resources ='IgnitebleIccSDK.bundle'
    s.dependency 'EstimoteSDK'

    s.ios.vendored_frameworks = 'IgnitebleIccSDK.framework'
    
end  