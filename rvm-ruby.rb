dep 'rvm-ruby', :version do 
  requires 'rvm', 'clear sources'
  met? {"/usr/local/rvm/rubies/#{version}/bin/ruby".p.exists? }
  meet {login_shell "rvm install #{version}", :sudo => true}
end

dep 'rvm-ruby-default', :version do 
  requires 'rvm-ruby'.with(version)
  met? {
    Regexp.new(version.to_s)  =~ login_shell("rvm list default") 
  }
  meet {login_shell "rvm --default use #{version}"}
end