Ransack.configure do |config|
  config.add_predicate 'array_contains', arel_predicate: :contains, wants_array: true
end
