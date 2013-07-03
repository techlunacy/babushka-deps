
dep 'devstack.repo' do
  met? { File.exists?(path) }
  meet { git source, :to => path }
end

dep 'devstack.variable_file' do
  requires 'devstack.repo'
  met? { variable_path. p.exists? }
  meet { shell "touch #{variable_path}" }
end

dep 'devstack.admin_password' do 
  requires 'devstack.variable_file'
  met? {has_variable?("ADMIN_PASSWORD") }
  meet { set_variable("ADMIN_PASSWORD","password") }
end

dep 'devstack.mysql_password' do 
  requires 'devstack.variable_file'
  met? {has_variable?("MYSQL_PASSWORD") }
  meet { set_variable("MYSQL_PASSWORD","password") }
end

dep 'devstack.rabbit_password' do 
  requires 'devstack.variable_file'
  met? {has_variable?("RABBIT_PASSWORD") }
  meet { set_variable("RABBIT_PASSWORD","password") }
end

dep 'devstack.service_password' do 
  requires 'devstack.variable_file'
  met? {has_variable?("SERVICE_PASSWORD") }
  meet { set_variable("SERVICE_PASSWORD","password") }
end

dep 'devstack.service_token' do 
  requires 'devstack.variable_file'
  met? {has_variable?("SERVICE_TOKEN") }
  meet { set_variable("SERVICE_TOKEN","tokentoken") }
end

dep 'devstack' do 
  requires 'devstack.admin_password', 'devstack.mysql_password', 'devstack.rabbit_password', 'devstack.service_password', 'devstack.service_token'
    met? {shell "curl localhost" }
  meet { shell "#{path}/stack.sh" }
end

def set_variable(name, value)
  variable_path.p.append("#{name}=#{value}\n")
end

def has_variable?(name)
  variable_path.p.read.include?(name)
end

def path
  File.expand_path '~/devstack'
end
def source
  'https://github.com/openstack-dev/devstack.git'
end

def variable_path
  path+'/localrc'
end