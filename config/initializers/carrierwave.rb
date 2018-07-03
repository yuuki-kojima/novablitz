CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJAWSZD24WSLJDRAQ',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'lp-novablitz-image'
  config.cache_storage = :fog
end
