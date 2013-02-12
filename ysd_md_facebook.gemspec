Gem::Specification.new do |s|
  s.name    = "ysd_md_facebook"
  s.version = "0.2.19"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2013-01-10"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb']
  s.summary = "Facebook model"
  s.homepage = "http://github.com/yuraksisa/ysd_md_facebook"  
  
  s.add_runtime_dependency "koala"
  s.add_runtime_dependency "ysd_md_profile"

end
