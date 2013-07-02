dep 'clear sources' do 
  met? {"/var/lib/apt/lists".p.empty? }
  meet {sudo "rm /var/lib/apt/lists/* -vrf"}
end