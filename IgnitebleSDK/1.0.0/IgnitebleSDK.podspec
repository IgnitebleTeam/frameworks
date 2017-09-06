Pod::Spec.new do |s|  
    s.name              = 'IgnitebleSDK'
    s.version           = '1.0.0'
    s.summary           = 'Igniteble SDK.'
    s.homepage          = 'https://github.com/IgnitebleTeam/frameworks/'

    s.author            = { 'Name' => 'sdk@example.com' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    #s.source            = { :path => './IngitebleSDK.zip' }
    s.source            = { :http => 'http://s3-us-west-2.amazonaws.com/igniteble-frameworks/IgnitebleIccSDK.zip' }

    #s.ios.deployment_target = '10.3'
    s.resources ='IgnitebleSDK.bundle'


    s.ios.vendored_frameworks = 'IgnitebleSDK.framework'
    
end  