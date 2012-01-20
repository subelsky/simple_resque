guard 'spork', :cucumber => false, :test_unit => false, :rspec => true, :rspec_port => 10000 do
  watch(%r{^spec/spec_helper.rb$})
end

guard 'rspec', :all_on_start => true do
  watch(%r{spec/(.*)_spec.rb})
  watch(%r{lib/(.*)\.rb})                            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                       { "spec" }
end
