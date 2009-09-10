# base_template.rb
# Basis-Template

# initializer laden
load_template 'http://github.com/akl/rails-templates/raw/master/initializers.rb'


# configuration laden 
capify!
load_template 'http://github.com/akl/rails-templates/raw/master/initializers.rb' 



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

run "touch public/stylesheets/base.css"
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

git :add => '.', :commit => "-m 'Erster commit'"
