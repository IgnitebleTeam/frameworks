Pod::Spec.new do |s|  
    s.name              = 'IgnitebleSDK'
    s.version           = '1.0.0'
    s.summary           = 'A really cool SDK that logs stuff.'
    s.homepage          = 'http://example.com/'

    s.author            = { 'Name' => 'sdk@example.com' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    #s.source            = { :path => './IngitebleSDK.zip' }
    s.source            = { :git => 'https://github.com/IgnitebleTeam/frameworks/IngitebleSDK.zip' }

    #s.ios.deployment_target = '8.0'
    s.resources ='IgnitebleSDK.bundle'


    s.ios.vendored_frameworks = 'IgnitebleSDK.framework'
    
end  