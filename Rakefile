# frozen_string_literal: true

require 'yaml'
require 'logger'
require 'active_record'

# rubocop:disable all
include ActiveRecord::Tasks

class Seeder
  def initialize(seed)
    @seed = seed
  end

  def load_seed
    raise "Seed file '#{@seed}' does not exist" unless File.file? @seed

    load @seed_file
  end
end

root = File.expand_path __dir__
DatabaseTasks.env = ENV['ENV'] || 'development'
conf = File.join root, 'db/database.yml'
DatabaseTasks.database_configuration = YAML.safe_load(File.read(conf))
DatabaseTasks.db_dir = File.join root, 'db'
DatabaseTasks.migrations_paths = [File.join(root, 'db/migrate')]
DatabaseTasks.seed_loader = Seeder.new File.join root, 'db/seeds.rb'
DatabaseTasks.root = root

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load 'active_record/railties/databases.rake'
