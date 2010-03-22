# geminstaller_builder

A simple tool for generating valid and up-to-date geminstaller files. Bundler
is probably what you want, but if you're supporting legacy apps or you just
like geminstaller, this could be helpful.

# Use

## Solo

    require 'geminstaller_builder'
    geminstaller = GeminstallerBuilder.new
    geminstaller.add 'haml'
    geminstaller.add 'state_machine'
    geminstaller.add 'shoulda', :test
    geminstaller.save

Will create two files:

`config/geminstaller.yml`:

    ---
    defaults:
      install-options: '--no-rdoc --no-ri'
    gems:
    - name: haml
      version: '= 2.2.22'
    - name: state_machine
      version: '= 0.8.1'

`config/test/geminstaller.yml`:

    ---
    defaults:
      install-options: '--no-rdoc --no-ri'
    gems:
    - name: shoulda
      version: '= 2.10.3'

relative to the directory from which the script was run.

By default, the `:default` and `:test` environments are assumed. To change the names of the files generated, pass in a `:paths` option with the full filenames. For example:

    require 'geminstaller_builder'
    geminstaller = GeminstallerBuilder.new :paths => {:default => 'geminstaller.yml', :test => 'geminstaller-test.yml'}
    geminstaller.add 'haml'
    geminstaller.add 'state_machine'
    geminstaller.add 'shoulda', :test
    geminstaller.save

will create `geminstaller.yml` and `geminstaller-test.yml`.

## In a Rails application template

Looks pretty much the same. I use it like this:

`template.rb`:

    # use geminstaller instead of gem
    require 'geminstaller_builder'
    @geminstaller = GeminstallerFile.new
    def geminstaller s, env=:default
      @geminstaller.add s, env
    end

    # later on ...
    geminstaller 'will_paginate'
    geminstaller 'hpricot'
    geminstaller 'json'
    geminstaller 'state_machine'
    geminstaller 'paperclip'

    load_template 'http://github.com/smartlogic/rails-templates/raw/master/test.rb'

and in `test.rb`:

    geminstaller 'factory_girl', :test
    geminstaller 'shoulda', :test
    geminstaller 'redgreen', :test
    geminstaller 'timecop', :test
    geminstaller 'hydra', :test
    geminstaller 'mocha', :test

    # etc...

Finally, at the end of `template.rb`, I have:

    @geminstaller.save

at which point, geminstaller_build consults the currently available gems to build the appropriate geminstaller.yml files.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally. But then, I haven't included any
  tests. So do what feels good.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Adam Bachman. See LICENSE for details.
