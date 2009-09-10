# base_template.rb
# Basis-Template

# Abhängigkeiten
#
# Gems
gem 'rubyist-aasm'
gem 'mislav-will_paginate', :version '~> 2.2.3', :lib => 'will_paginate', :source => 'http://gems.github.com'
gem 'binarylogic-authlogic', :lib => 'authlogic', :source => 'http://gems.github.com'
gem 'makandra-aegis', :lib => 'aegis', :source => 'http://gems.github.com'
gem 'mocha' if yes?('Benötigen Sie Mocha?')

rake ('gems:install', :sudo => true)


# Plugins
plugin 'exception-notifier', :git => 'git://github.com/rails/exception_notification.git'

if yes?('Möchten Sie RSpec verwenden?')
  plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git'
  plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git'
  generate :rspec
end


# Aufräumen
run "echo TODO > README"
inside('public') do
  %w( index.html favicon.ico robots.txt ).each { |d| run "rm -f #{d}" }
end


# Git aufsetzen
git :init

# Git ignore-file
file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

git :add => '.', :commit => "-m 'Erster commit'"
