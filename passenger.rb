
dep 'passenger' do 
  met? {shell 'dpkg --get-selections | grep nginx' }
  meet {sudo 'apt-get install -y nginx'}
end