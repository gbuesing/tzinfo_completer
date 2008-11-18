require 'rake'
gem 'activesupport', '2.2.1'
require 'activesupport'

namespace :tzinfo do
  task :update => ['tzinfo:copy_classes', 'tzinfo:copy_definitions', 'tzinfo:copy_indexes'] do
    Rake::Task['tzinfo:cleanup_tmp'].invoke
  end
  
  task :unpack_gem do
    mkdir_p "tmp"
    cd "tmp"
    sh "gem unpack --version #{ENV['VERSION'] || "'> 0'"} tzinfo"
    cd ".."
  end
  
  task :copy_classes => :unpack_gem do
    mkdir_p "lib/tzinfo"
    cp "#{tmp_path}/lib/tzinfo.rb", 'lib/tzinfo_completer.rb'
    files = FileList["#{tmp_path}/lib/tzinfo/*.rb"]
    files.each do |file|
      filename = File.basename(file)
      unless excluded_classes.include? filename.sub(/.rb$/, '')
        cp "#{tmp_path}/lib/tzinfo/#{filename}", "lib/tzinfo"
      end
    end
  end
  
  task :copy_definitions => :unpack_gem do
    definitions_path = "lib/tzinfo/definitions/"
    mkdir_p definitions_path
    cp_r "#{tmp_path}/lib/tzinfo/definitions/", "lib/tzinfo/"
    ActiveSupport::TimeZone::MAPPING.values.each do |zone|
      rm_f "#{definitions_path}#{zone}.rb"
    end
  end
  
  task :copy_indexes => :unpack_gem do
    cp_r "#{tmp_path}/lib/tzinfo/indexes/", "lib/tzinfo/"
  end

  task :cleanup_tmp do
    rm_rf "tmp"
  end
  
  def version
    ENV['VERSION'] ||= get_unpacked_version
  end
  
  def get_unpacked_version
    m = (FileList["tmp/tzinfo-*"].to_s.match /\d+\.\d+\.\d+/)
    m ? m[0] : raise(LoadError, "TZInfo gem must be installed locally. `gem install tzinfo` and try again")
  end
  
  def tmp_path
    "tmp/tzinfo-#{version}"
  end
  
  def excluded_classes
    # %w(country country_index_definition country_info country_timezone timezone_index_definition timezone_proxy tzdataparser)
    %w(data_timezone data_timezone_info info_timezone linked_timezone linked_timezone_info offset_rationals ruby_core_support time_or_datetime timezone timezone_definition timezone_info timezone_offset_info timezone_period timezone_transition_info)
  end
end
