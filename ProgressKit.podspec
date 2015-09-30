Pod::Spec.new do |s|
  s.name = 'ProgressKit'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'ProgressViews for Mac'
  s.homepage = 'https://github.com/kaunteya/ProgressKit'
  s.authors = { 'Kaunteya Suryawanshi' => 'k.suryawanshi@gmail.com' }
  s.source = { :git => 'https://github.com/kaunteya/ProgressKit.git', :tag => s.version }

  s.platform = :osx, '10.9'
  s.requires_arc = true

  s.source_files = 'InfoButton.swift'
end
