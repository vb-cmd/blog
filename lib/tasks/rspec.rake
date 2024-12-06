namespace :spec do
  desc 'Run a single spec file'
  task :file, [:path_to_file] do |_, args|
    path_to_file = args[:path_to_file]

    puts "Running spec: #{path_to_file}"

    system("bundle exec rspec #{path_to_file}")
  end
end
