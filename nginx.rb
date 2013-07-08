
dep 'nginx' do 
  requires 'passenger'
  met? {shell 'dpkg --get-selections | grep nginx' }
  meet {sudo 'apt-get install -y nginx'}
end