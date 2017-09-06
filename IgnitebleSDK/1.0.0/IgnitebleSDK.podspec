Pod::Spec.new do |s|  
    s.name              = 'IgnitebleSDK'
    s.version           = '1.0.0'
    s.summary           = 'Igniteble SDK.'
    s.homepage          = 'https://github.com/IgnitebleTeam/frameworks/'

    s.author            = { 'Name' => 'Sarkis Kaloustian Igniteble LLC Copyright 2017' }
    s.license          = 'Commercial'

    s.platform          = :ios
    #s.source            = { :path => './IngitebleSDK.zip' }
    s.source            = { :http => 'http://s3-us-west-2.amazonaws.com/igniteble-frameworks/IgnitebleSDK.zip' }

    #s.ios.deployment_target = '10.3'
    s.resources = 'IgnitebleSDK.bundle'


    s.ios.vendored_frameworks = 'IgnitebleSDK.framework'
    
end  