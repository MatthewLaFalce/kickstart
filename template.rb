require "fileutils"
require "shellwords"

# Copied from: https://github.com/mattbrictson/rails-template
# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("kickstart-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/MatthewLaFalce/kickstart.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{kickstart/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def rails_version
  @rails_version ||= Gem::Version.new(Rails::VERSION::STRING)
end

def rails_7_or_newer?
  Gem::Requirement.new(">= 7.0.0.alpha").satisfied_by? rails_version
end

def add_gems
  add_gem 'awesome_print', '~> 1.9', '>= 1.9.2', group: :development

  # DO THIS AFTER ALL GEMS ARE SET
  # Replace 'string' with "string" in the Gemfile so RuboCop is happy
  gsub_file "Gemfile", /'([^']*)'/, '"\1"'

  # Install gems
  run "bundle install"
end

def set_application_name
  # Add Application Name to Config
  environment "config.application_name = Rails.application.class.module_parent_name"

  # Announce the user where they can change the application name in the future.
  puts "You can change application name inside: ./config/application.rb"
end

def copy_templates
  remove_file "Procfile"
  remove_file "Procfile.dev"

  copy_file "Procfile"
  copy_file "Procfile.dev"
  copy_file ".foreman"

  directory "app", force: true

  route "root to: 'static#home'"
  route "get '/terms', to: 'static#terms'"
  route "get '/support', to: 'static#support'"
  route "get '/privacy', to: 'static#privacy'"
  route "get '/help', to: 'static#help'"
  route "get '/faq', to: 'static#faq'"
  route "get '/contact_us', to: 'static#contact_us'"
  route "get '/about_us', to: 'static#about_us'"
end

def add_tailwind
  rails_command "tailwindcss:install"
end

def add_javascript_pipeline
  rails_command "importmap:install"
  rails_command "turbo:install stimulus:install"
end

def add_gem(name, *options)
  gem(name, *options) unless gem_exists?(name)
end

def gem_exists?(name)
  IO.read("Gemfile") =~ /^\s*gem ['"]#{name}['"]/
end

unless rails_7_or_newer?
  puts "Please use Rails 7.0 or newer to create a Kickstart application"
end

# Main setup
add_template_repository_to_source_path

add_gems

after_bundle do
  set_application_name
  add_javascript_pipeline
  add_tailwind

  # Make sure Linux is in the Gemfile.lock for deploying
  run "bundle lock --add-platform x86_64-linux"

  copy_templates

  run "rails db:create && rails db:migrate"

  # Commit everything to git
  unless ENV["SKIP_GIT"]
    git :init
    git add: "."
    # git commit will fail if user.email is not configured
    begin
      git commit: %( -m 'Initial commit' )
    rescue StandardError => e
      puts e.message
    end
  end

  say
  say "Kickstart app successfully created!", :blue
  say
  say "To get started with your new app:", :green
  say "  cd #{original_app_name}"
  say
  say "  # Update config/database.yml with your database credentials"
  say
  say "  bin/dev"
end
