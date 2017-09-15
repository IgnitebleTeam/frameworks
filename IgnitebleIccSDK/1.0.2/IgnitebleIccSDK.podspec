Pod::Spec.new do |s|  
    s.name              = 'IgnitebleIccSDK'
    s.version           = '1.0.2'
    s.summary           = 'Igniteble ICC SDK'
    s.homepage          = 'https://github.com/IgnitebleTeam/frameworks/'

    s.author            = { 'Name' => 'sarkis kaloustian' }
    s.license          = 'Commercial'

    s.platform          = :ios
    #s.source            = { :path => './IngitebleIccSDK.zip' }
    s.source            = { :http => 'http://s3-us-west-2.amazonaws.com/igniteble-frameworks/IgnitebleIccSDK.zip' }

    #s.ios.deployment_target = '10.3'
    #s.resources ='IgnitebleIccSDK.bundle'
    s.dependency 'EstimoteSDK'

    s.ios.vendored_frameworks = 'IgnitebleIccSDK.framework'
    
end  