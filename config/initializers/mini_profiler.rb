if Rack.const_defined?('MiniProfiler')
  Rack::MiniProfiler.config.use_existing_jquery = true
end
