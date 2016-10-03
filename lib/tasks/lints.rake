begin
  require 'rubocop/rake_task'
rescue LoadError
  puts 'Rubocop tasks are unavailable'
else
  RuboCop::RakeTask.new do |rubocop|
    rubocop.formatters = ['progress']
    if ENV['CIRCLE_TEST_REPORTS']
      rubocop.requires << 'rubocop/formatter/junit_formatter'
      rubocop.formatters << [
        'RuboCop::Formatter::JUnitFormatter',
        '--out', "#{ENV['CIRCLE_TEST_REPORTS']}/rubocop/junit.xml"
      ]
    end
  end
  task :default => :rubocop
end
