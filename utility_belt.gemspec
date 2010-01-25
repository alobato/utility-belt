# http://docs.rubygems.org/read/chapter/20
# http://akitaonrails.com/2009/2/7/anatomia-de-uma-rubygem

SPEC = Gem::Specification.new do |s| 
  s.name = "alobato-utility_belt"
  s.version = "1.0.13"
  s.author = "Giles Bowkett"
  s.email = "gilesb@gmail.com"
  s.summary = "A grab-bag of IRB power user madness. -- now with linux"
  s.require_path = "lib"
  
  # run git ls-files to get an updated list
  s.files = %w[
    History.txt
    Manifest.txt
    README
    bin/amazon
    bin/google
    bin/pastie
    html/andreas00.css
    html/authorship.html
    html/bg.gif
    html/front.jpg
    html/index.html
    html/menubg.gif
    html/menubg2.gif
    html/test.jpg
    html/usage.html
    lib/utility_belt.rb
    lib/utility_belt/active_record_dsl.rb
    lib/utility_belt/active_record_log.rb
    lib/utility_belt/amazon_upload_shortcut.rb
    lib/utility_belt/array_numberings.rb
    lib/utility_belt/benchmark.rb
    lib/utility_belt/clipboard.rb
    lib/utility_belt/command_history.rb
    lib/utility_belt/convertable_to_file.rb
    lib/utility_belt/equipper.rb
    lib/utility_belt/google.rb
    lib/utility_belt/hash_math.rb
    lib/utility_belt/hirb.rb
    lib/utility_belt/interactive_editor.rb
    lib/utility_belt/irb_options.rb
    lib/utility_belt/irb_verbosity_control.rb
    lib/utility_belt/is_an.rb
    lib/utility_belt/language_greps.rb
    lib/utility_belt/methods.rb
    lib/utility_belt/not.rb
    lib/utility_belt/pastie.rb
    lib/utility_belt/pipe.rb
    lib/utility_belt/print_methods.rb
    lib/utility_belt/rails_finder_shortcut.rb
    lib/utility_belt/rails_verbosity_control.rb
    lib/utility_belt/regexp.rb
    lib/utility_belt/string_to_proc.rb
    lib/utility_belt/symbol_to_proc.rb
    lib/utility_belt/webbrowser.rb
    lib/utility_belt/wirble.rb
    lib/utility_belt/with.rb
    utility_belt.gemspec
  ]
  
  s.test_files = %w[
    spec/array_numberings_spec.rb
    spec/convertable_to_file_spec.rb
    spec/equipper_spec.rb
    spec/hash_math_spec.rb
    spec/interactive_editor_spec.rb
    spec/language_greps_spec.rb
    spec/pastie_spec.rb
    spec/pipe_spec.rb
    spec/spec_helper.rb
    spec/string_to_proc_spec.rb
    spec/utility_belt_spec.rb
  ]

  %w{amazon google pastie}.each do |command_line_utility|
    s.executables << command_line_utility
  end
  
  s.has_rdoc = true 
  s.extra_rdoc_files = ["README"]
  s.add_dependency("Platform", ">= 0.4.0")
  s.add_dependency("ruby2ruby", ">= 1.1.9")
  # s.add_dependency("activesupport")
  # s.add_dependency("wirble", ">= 0.1.2")
  # s.add_dependency("aws-s3", ">= 0.5.1")
end 
