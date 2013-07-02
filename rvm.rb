
dep 'rvm' do 
  met? { '/usr/local/rvm/src/rvm/scripts/rvm'.p.file? }
  meet { sudo 'curl -L https://get.rvm.io | bash -s stable' }
end