require 'csv'

desc 'Import development data from provided csv files.'
task :import_csv_files => :environment do
  destroy_all_records
  seed_all_csv_files
  convert_price_to_dollar_for(Item)
  convert_price_to_dollar_for(InvoiceItem)
  reset_primary_sequences
end

def destroy_all_records
  puts "I have been ordered to destroy all records!"
  models_and_files.each do |model, _|
    model.destroy_all
    puts "#{model} destroyed!"
  end
end

def convert_price_to_dollar(model)
  require 'pry'; binding.pry
end

def seed_all_csv_files
  models_and_files.each do |model, file|
    seed_from_csv(model, file)
    puts "\nComplete seed for #{model} from #{file}"
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
  puts "Updating unit_price for #{model}"
  model.all.each do |record|
    cents = record.unit_price
    record.update(unit_price: ('%.2f' % (cents.to_i/100.0)))
    print '.'
  end
end

def reset_primary_sequences
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end
end
