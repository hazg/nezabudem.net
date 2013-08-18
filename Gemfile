source 'https://rubygems.org'

gem 'sape-rails', :git => 'git://github.com/hazg/sape-rails'

gem 'forem', :git => 'git://github.com/radar/forem.git'
gem 'forem-theme-base', :git => 'git://github.com/radar/forem-theme-base.git'
#gem 'rails'
#gem 'sinatra'
gem 'acts_as_commentable_with_threading' #, :path => '../git/acts_as_commentable_with_threading'
gem 'simple-private-messages', '0.0.0', :git => 'https://github.com/jongilbraith/simple-private-messages.git'
gem 'paper_trail'
# Bundle edge Rails instead:
gem 'rails', :branch => '3-2-stable', :git => 'git://github.com/rails/rails.git'
# gem 'scrib', :path => '../git/scrib/'
# gem 'rack-mini-profiler'
gem 'mysql2'
#gem 'ckeditor', :git => 'git://github.com/galetahub/ckeditor.git'
#gem 'gmaps4rails'
gem 'acts-as-taggable-on'
gem 'breadcrumbs_on_rails', :git => 'https://github.com/weppos/breadcrumbs_on_rails'

gem 'whenever', :require => false

gem 'ancestry'
gem 'responders'
gem 'has_scope'
gem 'mini_magick'
gem 'paper_trail'
gem 'friendly_id', :git => 'https://github.com/norman/friendly_id'
gem 'simple_form'
gem 'carrierwave'
gem 'haml-rails'
gem 'awesome_print'
gem 'kaminari'
#gem 'has_scope'
gem 'russian'
gem 'devise', :git => 'git://github.com/plataformatec/devise'
gem 'cancan'#, '1.6.7'
gem 'devise-russian'
gem 'builder'
gem 'rails_admin' #, :git => 'git://github.com/sferik/rails_admin'
#gem 'rails_admin_tag_list', :git => 'git://github.com/kryzhovnik/rails_admin_tag_list.git'
gem 'bootstrap-sass', '2.0.3' #, :git => 'git://github.com/hazg/bootstrap-sass.git', :branch=>'patch-1'
gem 'coffee-filter'
gem 'thinking-sphinx', github: 'pat/thinking-sphinx'
#gem 'thinking-sphinx', '2.0.10'

# Gems used only for assets and not required
# in production environments by default.
gem 'json_builder'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'bullet'
  gem 'debugger'
  gem 'pry-rails'
  #gem 'pry-stack_explorer'
  gem 'pry-debugger'
  gem 'rack-mini-profiler'
  gem 'better_errors'
end


group :assets do
  gem 'therubyracer', '0.10.2'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier', '>= 1.0.3'

end
gem 'compass'

# Gems used only for assets and not required
# in production environments by default.

gem 'jquery-rails'
# gem 'blankslate', :git => 'git://github.com/kdurski/blankslate'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
#
#
if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end
