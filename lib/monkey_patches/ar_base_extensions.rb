module ActiveRecord
  class Base
    # add a class method to all ActiveRecord models that by default says they should not be imported from bell,
    # to be overridden in the models that do derive their data from bell tables
    def self.import_from_bell
      false
    end
  end

  # support migrations creating tables with composite primary keys. Syntax is, e.g.,
  # create_table :index_queue, :primary_key => [:content_id, :content_type] do |t|
  # monkey patch overrides #to_sql in vendor/rails/activerecord/lib/active_record/connection_adapters/abstract/schema_definitions.rb
  module ConnectionAdapters
    class ColumnDefinition
      def to_sql
        if name.is_a? Array
          column_sql = "PRIMARY KEY (#{name.join(',')})"
        else
          column_sql = "#{base.quote_column_name(name)} #{sql_type}"
          column_options = {}
          column_options[:null] = null unless null.nil?
          column_options[:default] = default unless default.nil?
          add_column_options!(column_sql, column_options) unless type.to_sym == :primary_key
        end
        column_sql
      end
      alias to_s :to_sql
    end
  end

end
