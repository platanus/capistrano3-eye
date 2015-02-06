namespace :load do
  task :defaults do
    set :eye_roles, -> { :app }
    set :eye_template, -> { "config/deploy/#{fetch(:stage)}/#{fetch(:application)}.eye.erb" }
  end
end

namespace :eye do

  %w[start stop restart info].each do |command|
    desc "#{command.capitalize} wathed process"
    task command do
      on release_roles fetch(:eye_roles) do
        within "#{current_path}" do
          execute :bundle, "exec eye", "#{command}"
        end
      end
    end
  end

  desc "Load eye config"
  task :load do
    on release_roles fetch(:eye_roles) do
      within "#{shared_path}/config" do
        execute :eye, "load", "#{fetch(:application)}.eye"
      end
    end
  end

  desc "Upload eye configuration file"
  task :setup do
    on release_roles fetch(:eye_roles) do
      within "#{shared_path}/config" do
        config_file = fetch(:eye_template)
        unless File.exists?(config_file)
          config_file = File.expand_path("../../../../templates/app.eye.erb", __FILE__)
        end
        config = ERB.new(File.read(config_file)).result(binding)
        upload! StringIO.new(config), "/tmp/#{fetch(:application)}.eye"

        execute :mv, "/tmp/#{fetch(:application)}.eye", "#{fetch(:application)}.eye"
      end
    end
  end
end
