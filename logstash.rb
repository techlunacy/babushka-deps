dep 'java.bin' do
  requires 'clear sources'
  installs 'openjdk-7-jre-headless'
end

dep 'logstash' do 
  requires 'java.bin'

  local_path = '/root/.babushka/build/logstash-1.1.13-flatjar.jar'
  url = "http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar"
  met? {local_path.p.exists? }
  meet { Babushka::Resource.download url }
end

dep 'elastic search download' do
  local_path = '/root/.babushka/build/elasticsearch-0.90.2/elasticsearch-0.90.2/bin/elasticsearch'
  url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.2.tar.gz"

  met? {local_path.p.exists? }
  meet { Babushka::Resource.extract url }
end

dep 'elastic search' do
  requires 'elastic search download'
  local_path = '/root/.babushka/build/elasticsearch-0.90.2/elasticsearch-0.90.2/bin/'
  met? {shell "curl localhost:9200"}
  meet { sudo "cd #{local_path};./elasticsearch start" }
end