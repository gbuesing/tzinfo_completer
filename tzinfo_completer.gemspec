require 'fileutils'

Gem::Specification.new do |s|
  s.name     = "tzinfo_completer"
  s.version  = "0.3.12"
  s.date     = "2008-11-17"
  s.summary  = "Contains the parts of the TZInfo gem not included in the slimmed-down version in ActiveSupport"
  s.homepage = "http://github.com/gbuesing/tzinfo_completer"
  s.files    = FileList['LICENSE', 'Rakefile', 'README', 'lib/**/*']
end
