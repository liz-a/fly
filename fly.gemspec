Gem::Specification.new do |s|
    s.name = %q{fly}
    s.version = '0.0.1'
    s.date = %q{2019-01-19}
    s.authors = 'Liz'
    s.summary = %q{sends messages to rabbitmq}
    s.files = [
        'lib/fly.rb',
        'lib/exchanges/*.rb'
    ]
    s.require_paths = ['lib']
    s.add_dependency 'bunny'
    s.add_development_dependency "rspec"
end