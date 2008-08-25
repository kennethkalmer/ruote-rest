
require 'fileutils'

namespace :ruote do

  RUFUSES = %w{ 
    dollar lru mnemo scheduler verbs sixjo }.collect { |e| "rufus-#{e}" }

  #
  # do use either ruote:install or ruote:gem_install
  # but not both
  #


  desc "Installs under vendor/ the latest source of OpenWFEru (and required subprojects)."
  task :install => :get_from_github do

    #sh "sudo gem install --no-rdoc --no-ri json_pure"
    #sh "sudo gem install --no-rdoc --no-ri json"
    sh "sudo gem install --no-rdoc --no-ri activerecord"
    sh "sudo gem install --no-rdoc --no-ri rogue_parser"
    #sh "sudo gem install --no-rdoc --no-ri -v 0.2.2 sinatra"
  end

  task :get_from_github do

    FileUtils.mkdir 'tmp' unless File.exists?('tmp')

    sh "rm -fR vendor/ruote"
    sh "rm -fR vendor/rufus"
    sh "mkdir vendor"

    RUFUSES.each { |e| git_clone(e) }
    git_clone "ruote"
  end

  def git_clone (elt)

    sh "cd tmp && git clone git://github.com/jmettraux/#{elt}.git"
    sh "cp -pR tmp/#{elt}/lib/* vendor/"
    sh "rm -fR tmp/#{elt}"
  end

  desc "Install Ruote and its dependencies as gems"
  task :gem_install do

    GEMS = RUFUSES.dup

    GEMS << 'ruote'
    #GEMS << 'ruote-extras'

    #GEMS << 'json_pure'
    #GEMS << 'json'
    GEMS << 'rogue_parser'
    GEMS << 'activerecord'

    sh "sudo gem install --no-rdoc --no-ri #{GEMS.join(' ')}"
    #sh "sudo gem install --no-rdoc --no-ri -v 0.2.2 sinatra"

    #puts
    #puts "installed gems  #{GEMS.join(' ')}"
    #puts
  end
end

