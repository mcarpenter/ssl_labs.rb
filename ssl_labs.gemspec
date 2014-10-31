Gem::Specification.new do |s|
  s.add_dependency('activesupport', '>= 4.0.1')
  s.add_dependency('mechanize', '>= 1.0.0')
  s.add_dependency('json', '>= 1.8.1')
  s.authors = ['Martin Carpenter']
  s.date = Time.now.strftime('%Y-%m-%d')
  s.description = 'A gem to interface with ssllabs.com scanner'
  s.email = 'mcarpenter@free.fr'
  s.extra_rdoc_files = %w{ Rakefile README.md }
  s.files = FileList['lib/**/*', 'test/**/*'].to_a
  s.has_rdoc = true
  s.homepage = 'https://github.com/mcarpenter/ssl_labs.rb'
  s.licenses = ['Apache 2.0']
  s.name = 'ssl_labs'
  s.platform = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = nil
  s.summary = 'ssllabs.com SSL/TLS vulnerability scanning client'
  s.test_files = FileList["{test}/**/test_*.rb"].to_a
  s.version = SslLabs::VERSION
end
