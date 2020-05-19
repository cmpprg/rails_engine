require 'csv'

desc 'Import development data from provided csv files.'
task :import_files => :environment do
  destroy_all_records
  seed_all_csv_files
  cents_to_dollar
  reset_primary_sequences
end

def destroy_all_records
  puts "***Destroying All Records!***"
  models_and_files.each do |model, _|
    model.destroy_all
    puts "***#{model} destroyed!***"
  end
end

def seed_all_csv_files
  puts '***Seeding Database***'
  models_and_files.each do |model, file|
    seed_from_csv(model, file)
    puts "\n***Complete seed for #{model} from #{file}***"
  end
end

def models_and_files
  {
    Customer => 'customers.csv', Merchant => 'merchants.csv',
    Item => 'items.csv', Invoice => 'invoices.csv',
    InvoiceItem => 'invoice_items.csv', Transaction => 'transactions.csv'
  }
end

def seed_from_csv(model, file)
  CSV.foreach(file_path_for(file), headers: true) do |row|
    model.create(row.to_h)
    print '.'
  end
end

def file_path_for(file)
  File.join(Rails.root, 'data', file)
end

def convert_price_to_dollar_for(model)
  puts "\n***Updating unit_price for #{model}***"
  model.all.each do |record|
    cents = record.unit_price
    record.update(unit_price: ('%.2f' % (cents.to_i/100.0)))
    print '.'
  end
end

def cents_to_dollar
  [Item, InvoiceItem].each { |model| convert_price_to_dollar_for(model) }
end

def reset_primary_sequences
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end
end
